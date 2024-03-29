//
//  WorkspaceAssembly.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/09.
//

import Swinject

final class WorkspaceDomainAssembly: Assembly {
    func assemble(container: Container) {
        let appState = container.resolve(AppState.self)!
        let workspaceRepository = container.resolve(WorkspaceRepository.self)!
        container.register(CreateWorkspaceUseCase.self) { _ in
            return DefaultCreateWorkspaceUseCase(appState: appState, workspaceRepository: workspaceRepository)
        }
        container.register(EditWorkspaceUseCase.self) { _ in
            return DefaultEditWorkspaceUseCase(appState: appState, workspaceRepository: workspaceRepository)
        }
        container.register(ChangeWorkspaceAdminUseCase.self) { _ in
            return DefaultChangeWorkspaceAdminUseCase(workspaceRepository: workspaceRepository, appState: appState)
        }
        container.register(SelectWorkspaceUseCase.self) { resolver in
            return DefaultSelectWorkspaceUseCase(appState: appState, workspaceRespotory: workspaceRepository)
        }
        container.register(InviteMemberUsecase.self) { _ in
            return DefaultInviteMemberUsecase(appState: appState, workspaceRepository: workspaceRepository)
        }
        container.register(OutWorkspaceUsecase.self) { resolver in
            let channelRepository = resolver.resolve(ChannelRepository.self)!
            return DefaultOutWorkspaceUsecase(workspaceRepository: workspaceRepository, channelRepository: channelRepository, appState: appState)
        }
    }
}
