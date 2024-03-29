//
//  ChannelListItemModel.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/23.
//

import Foundation

struct ChannelListItemModel: Hashable, Identifiable {
    
    let workspaceId: Int
    let id: Int
    var name: String
    var description: String?
    var ownerId: Int
    var isSecret: Bool?
    let createdAt: Date
    var newMessageCount: Int
    
    init(channelList: ChannelThumbnail) {
        workspaceId = channelList.workspaceId
        id = channelList.channelId
        name = channelList.name
        description = channelList.description
        ownerId = channelList.ownerId
        isSecret = channelList.secret
        createdAt = channelList.createdAt
        newMessageCount = 0
    }
}

