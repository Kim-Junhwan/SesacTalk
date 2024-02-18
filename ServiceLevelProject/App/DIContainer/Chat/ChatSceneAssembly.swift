//
//  ChatSceneAssembly.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/16.
//

import Swinject

class ChatSceneAssembly: Assembly {
    func assemble(container: Container) {
        let appState = container.resolve(AppState.self)!
        container.register(HomeViewModel.self) { _ in
            return HomeViewModel(appState: appState)
        }
    }
}