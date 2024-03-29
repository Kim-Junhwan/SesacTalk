//
//  HomeViewModel.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/16.
//

import Combine
import Foundation

final class HomeViewModel: ViewModel {
    enum HomeViewInput {
        case appearView
    }
    
    struct HomeViewModelState {
        var navigationTitle: String
        var currentWorkspace: WorkspaceDetailInfo?
        var workspaceIsEmpty: Bool = true
        var selectedTabIndex: Int = 0
    }
    
    @Published var workspaceImage: FetchImageModel
    @Published var userProfileImage: FetchImageModel
    @Published var state: HomeViewModelState
    private let appState: AppState
    private let selectWorkspaceUseCase: SelectWorkspaceUseCase
    private var cancellableBag = Set<AnyCancellable>()
    
    init(appState: AppState, selectWorkspaceUseCase: SelectWorkspaceUseCase) {
        self.appState = appState
        self.state = .init(navigationTitle: appState.currentWorkspace?.name ?? "No Workspace")
        self.workspaceImage = .init(url: nil)
        self.userProfileImage = .init(url: appState.userData.profileImagePath)
        self.selectWorkspaceUseCase = selectWorkspaceUseCase
        bindAppState()
    }
    
    private func bindAppState() {
        appState.$userData
            .receive(on: RunLoop.main)
            .sink { userData in
                self.userProfileImage.url = userData.profileImagePath
            }
            .store(in: &cancellableBag)
        
        appState.$workspaceList
            .receive(on: RunLoop.main)
            .sink(receiveValue: { workspaceList in
                self.state.workspaceIsEmpty = workspaceList.isEmpty
                if workspaceList.isEmpty {
                    self.state.currentWorkspace = nil
                } else {
                    self.state.navigationTitle = self.appState.currentWorkspace?.name ?? "No Workspace"
                }
            })
            .store(in: &cancellableBag)
        
        appState.$selectWorkspace
            .receive(on: RunLoop.main)
            .sink { selectWorkspace in
                self.state.currentWorkspace = selectWorkspace
                self.workspaceImage.url = selectWorkspace?.thumbnail
                if self.state.selectedTabIndex == 0 {
                    self.state.navigationTitle = selectWorkspace?.name ?? "No Workspace"
                }
            }
            .store(in: &cancellableBag )
    }
    
    func trigger(_ input: HomeViewInput) {
        switch input {
        case .appearView:
            //가장 최근에 선택된 worspace로 상태 변경
            if let currentWorkspace = appState.currentWorkspace {
                selectWorkspace(workspaceId: currentWorkspace.id)
            }
        }
    }
    
    private func selectWorkspace(workspaceId: Int) {
        Task {
            do {
                try await selectWorkspaceUseCase.excute(workspaceId: workspaceId)
            }
        }
    }
}
