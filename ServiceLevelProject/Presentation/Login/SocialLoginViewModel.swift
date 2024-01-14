//
//  LoginViewModel.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/05.
//

import Foundation

final class SocialLoginViewModel: ViewModel {
    
    struct LoginState {
        var error: Error?
        var isLoading: Bool = false
        var successLogin: Bool = false
    }
    
    enum SocialLoginInput {
        case appleLogin(idToken: Data, nickName: PersonNameComponents)
        case kakaoLogin
    }
    
    @Published var state: LoginState
    
    init() {
        state = LoginState()
    }
    
    func trigger(_ input: SocialLoginInput) {
        
    }
    
    
}