//
//  ChatsService.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 15/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import RxFirebase
import FirebaseFirestore
import RxSwift
import Firebase

public class ChatService {
    
    private let chatParser: ChatParser
    
    private lazy var roomsRef = Firestore.firestore().collection("rooms")
    private lazy var usersRef = Firestore.firestore().collection("users")
    
    private lazy var auth: Auth = Auth.auth()
    
    init(withChatParser chatParser: ChatParser) {
        self.chatParser = chatParser
    }
    
    func getChats() -> Observable<[Chat]> {
        guard let userId = auth.currentUser?.uid else {
            return Observable.just([])
        }
        
        return roomsRef
            .rx
            .listen()
            .map({ [weak self] (snapshot) -> [Chat] in
                self?.chatParser.parse(source: snapshot) ?? []
            }).flatMap({ chats -> Observable<[Chat]> in
                self.usersRef.document(userId)
                    .collection("rooms")
                    .rx
                    .getDocuments()
                    .map({ (documents) in
                        documents.documents.map({ snapshot in
                            snapshot.documentID
                        })
                    })
                    .flatMap({ (chatsIds) -> Observable<[Chat]> in
                        Observable.from(chats)
                            .filter({ chat in
                                chatsIds.contains(chat.roomId)
                            })
                            .toArray()
                            .asObservable()
                    })
//                Observable.from(chats)
//                    .flatMap({ chat -> Observable<Chat> in
//                        self.roomsRef.document(chat.roomId)
//                        .collection("users")
//                        .rx
//                        .getDocuments()
//                        .map({ snapshots in
//                            for i in 0..<snapshots.documents.count {
//                                let data = snapshots.documents[i].documentID
//                                chat.users.append(data)
//                            }
//                            return chat
//                        })
//                    })
//                    .filter({ (chat) -> Bool in
//                        chat.users.contains(userId)
//                    })
//                    .toArray()
//                    .asObservable()
            })
    }
    
}
