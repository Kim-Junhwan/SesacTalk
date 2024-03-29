//
//  WorkspaceDetailInfo.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/15.
//

import Foundation

struct WorkspaceDetailInfo {
    let workspaceId: Int
    let name: String
    let description: String?
    let thumbnail: String
    let ownerId: Int
    let createdAt: Date
    let channels: [ChannelThumbnail]
    var workspaceMembers: [UserThumbnail]
}
