//
//  EditWorkspaceUseCase.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/14.
//

import Foundation

protocol EditWorkspaceUseCase {
    func excute(_ query: EditWorkspaceQuery) async throws
}

final class DefaultEditWorkspaceUseCase {
    let appState: AppState
    let workspaceRepository: WorkspaceRepository
    
    init(appState: AppState, workspaceRepository: WorkspaceRepository) {
        self.appState = appState
        self.workspaceRepository = workspaceRepository
    }
}

extension DefaultEditWorkspaceUseCase: EditWorkspaceUseCase {
    func excute(_ query: EditWorkspaceQuery) async throws {
        let value = try await workspaceRepository.editWorkspace(query)
        let fetchList = try await workspaceRepository.fetchComeInWorkspaceList()
        DispatchQueue.main.async {
            self.appState.workspaceList = fetchList.list
        }
    }
    
    
}
