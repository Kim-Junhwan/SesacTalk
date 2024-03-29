//
//  WorkspaceRepository.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/27.
//

import Foundation

protocol WorkspaceRepository {
    func fetchComeInWorkspaceList() async throws -> WorkspaceList
    func createWorkspace(_ query: CreateWorkspaceQuery) async throws -> WorkSpaceThumbnail
    func editWorkspace(_ query: EditWorkspaceQuery) async throws -> WorkSpaceThumbnail
    func fetchWorkspaceMembers(_ query: FetchWorkspaceMembersQuery) async throws -> [UserThumbnail]
    func fetchDetailWorkspace(_ query: FetchDetailWorkspaceInfoQuery) async throws -> WorkspaceDetailInfo
    func inviteMember(_ query: InviteMemberQuery) async throws -> UserThumbnail
    func outWorkspace(_ workspaceId: Int) async throws -> [WorkSpaceThumbnail]
}
