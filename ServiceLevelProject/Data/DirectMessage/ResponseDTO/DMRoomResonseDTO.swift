//
//  DMRoomResonseDTO.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/23.
//

import Foundation

struct DMRoomResonseDTO: Decodable {
    let workspaceId: Int
    let roomId: Int
    let createdAt: String
    let user: UserThumbnailResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case workspaceId = "workspace_id"
        case roomId = "room_id"
        case createdAt
        case user
    }
    
    func toDomain() throws -> DirectMessageRoom {
        return .init(workspaceId: workspaceId, roomId: roomId, createdAt: try createdAt.toDate(), user: user.toDomain())
    }
}
