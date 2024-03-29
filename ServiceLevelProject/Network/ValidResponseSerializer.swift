//
//  ValidResponseSerializer.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/12.
//

import Foundation
import Alamofire

class SLPResponseSerializer<T: Decodable, ErrorMapper: ResponseErrorMapper, S: Sequence>: ResponseSerializer where S.Iterator.Element == Int {
    
    let responseErrorMapper: ErrorMapper?
    let decoder: DataDecoder
    let emptyResponseCodes: Set<Int>
    let acceptableStatusCode: S
    
    init(statusCode acceptableStatusCode: S,
         decoder: DataDecoder = JSONDecoder(),
         emptyResponseCodes: Set<Int> = SLPResponseSerializer.defaultEmptyResponseCodes,
         responseErrorMapper: ErrorMapper
    ) {
        self.decoder = decoder
        self.emptyResponseCodes = emptyResponseCodes
        self.responseErrorMapper = responseErrorMapper
        self.acceptableStatusCode = acceptableStatusCode
    }

    func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> T {
        guard error == nil, let response else { throw error! }
        guard let data, !data.isEmpty else {
            return try responseEmpty(request: request, response: response)
        }
        if !acceptableStatusCode.contains(response.statusCode) {
            let errorCode = try decoder.decode(SLPErrorModel.self, from: data).errorCode
            try mappingError(errorCode: errorCode)
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
        }
    }
    
    private func mappingError(errorCode: String) throws {
        if let requestError = responseErrorMapper?.mappingError(errorCode) {
            throw requestError
        } else {
            throw SLPCommonError.init(rawValue: errorCode) ?? DefaultNetworkingError.unknownResponseError
        }
    }
    
    private func responseEmpty(request: URLRequest?, response: HTTPURLResponse?) throws -> T {
            guard emptyResponseAllowed(forRequest: request, response: response) else {
                throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
            }
            guard let emptyResponseType = T.self as? EmptyResponse.Type, let emptyValue = emptyResponseType.emptyValue() as? T else {
                throw AFError.responseSerializationFailed(reason: .invalidEmptyResponse(type: "\(T.self)"))
            }
            return emptyValue
    }
}

struct EmptyErrorMapper: ResponseErrorMapper {
    struct ResponseError: Error {}
    
    func mappingError(_ identifier: String) -> Error? {
        return nil
    }
}

extension DataRequest {
    func slpSerializingDecodable<Value: Decodable, S: Sequence>(_ type: Value.Type = Value.self,
                                                                statusCode acceptableStatusCode: S = 200..<300,
                                                   automaticallyCancelling shouldAutomaticallyCancel: Bool = true,
                                                   decoder: DataDecoder = JSONDecoder(),
                                                   emptyResponseCodes: Set<Int> = DecodableResponseSerializer<Value>.defaultEmptyResponseCodes,
                                                   responseErrorMapper: some ResponseErrorMapper = EmptyErrorMapper()
    ) -> DataTask<Value> where S.Iterator.Element == Int {
        serializingResponse(using: SLPResponseSerializer(statusCode: acceptableStatusCode, decoder: decoder, emptyResponseCodes: emptyResponseCodes, responseErrorMapper: responseErrorMapper) , automaticallyCancelling: shouldAutomaticallyCancel)
    }
    
    @discardableResult
    func slpResponseDecodable<T: Decodable, S: Sequence> (of type: T.Type = T.self,
                                                queue: DispatchQueue = .main,
                                                statusCode acceptableStatusCode: S = 200..<300,
                                                dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor,
                                                decoder: DataDecoder = JSONDecoder(),
                                                emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                                                responseErrorMapper: some ResponseErrorMapper = EmptyErrorMapper(),
                                                completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self where S.Iterator.Element == Int {
        response(queue: queue,
                 responseSerializer: SLPResponseSerializer(statusCode: acceptableStatusCode, decoder: decoder, emptyResponseCodes: emptyResponseCodes, responseErrorMapper: responseErrorMapper),
                 completionHandler: completionHandler)
    }
}
