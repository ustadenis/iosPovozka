//
//  Chat.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 15/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

public class Chat {
    public static let COLLECTION_TITLE: String = "rooms"
    public static let DOC_FILED_TITLE: String = "title"
    public static let DOC_FIELD_CREATED_AT: String = "createdAt"
    public static let DOC_FIELD_JOINED_AT: String = "joinedAt"
    public static let DOC_FIELD_LAST_VISIT: String = "lastVisit"
    
    public var roomId: String
    public var title: String
    public var createdAt: Date
    public var unreadMessageCount: Int
    
    public var users: [String] = []
    
    init(
        withRoomId roomId: String,
        andTitle title: String,
        andCreatedAt createdAt: Date,
        andMessageCount unreadMessageCount: Int
    ) {
        self.roomId = roomId
        self.title = title
        self.createdAt = createdAt
        self.unreadMessageCount = unreadMessageCount
    }
}
