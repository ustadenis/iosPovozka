//
//  ChatsViewModel.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 13/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import RxSwift

public protocol ChatsViewModeling {
    var chatsObservable: PublishSubject<[Chat]> { get }
    
    func subscribe()
    func unsubscribe()
}

public class ChatsViewModel {
    
    public var chatsObservable: PublishSubject<[Chat]> = PublishSubject.init()
    
    private var chats: [Chat] = [] {
        didSet {
            chatsObservable.onNext(chats)
        }
    }
    
    private var disposables: DisposeBag = DisposeBag()
    
    private var chatService: ChatService?
    
    init(withChatsService chatService: ChatService) {
        self.chatService = chatService
    }
    
}

extension ChatsViewModel: ChatsViewModeling {
    
    public func subscribe() {
        chatService?.getChats()
            .subscribe({ (chats) in
                if let unwrappedChats = chats.element {
                    self.chats = unwrappedChats
                }
            })
            .disposed(by: disposables)
    }
    
    public func unsubscribe() {
        
    }
    
}
