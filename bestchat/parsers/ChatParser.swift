//
//  ChatParser.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 15/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import FirebaseFirestore

public class ChatParser: Parser {
    
    typealias TSource = QuerySnapshot
    typealias TTarget = [Chat]
    
    func parse(source: QuerySnapshot) -> [Chat] {
        var chats: [Chat] = []
        source.documents.forEach { (snapshot) in
            let data = snapshot.data()
            let chat = Chat(
                withRoomId: snapshot.documentID,
                andTitle: data[Chat.DOC_FILED_TITLE] as! String,
                andCreatedAt:  Date(timeIntervalSince1970: TimeInterval(exactly: data[Chat.DOC_FIELD_CREATED_AT] as! Int64)!),
                andMessageCount: 0
            )
            chats.append(chat)
        }
        return chats
    }
    
}
