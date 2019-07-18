//
//  DI+SwInject.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 12/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    
    @objc class func setup() {
        registerUtils()
        registerServices()
        registerViewModels()
        registerRouters()
        registerControllers()
    }

    @objc class func registerViewModels() {
        defaultContainer.register(AuthViewModeling.self) { _ in
            AuthViewModel()
        }
        defaultContainer.register(ChatsViewModeling.self) { r in
            ChatsViewModel(withChatsService: r.resolve(ChatService.self)!)
        }
    }
    
    @objc class func registerUtils() {
        defaultContainer.register(ChatParser.self) { r in
            ChatParser()
        }
    }
    
    @objc class func registerRouters() {
        defaultContainer.register(AuthRouting.self) { (r, controller) in
            AuthRouter(with: controller as StartAuthViewController)
        }
        defaultContainer.register(ChatsRouting.self) { (r, controller) in
            ChatsRouter(with: controller as ChatsViewController)
        }
    }
    
    @objc class func registerServices() {
        defaultContainer.register(ChatService.self) { r in
            ChatService(withChatParser: r.resolve(ChatParser.self)!)
        }
    }
    
    @objc class func registerControllers() {
        defaultContainer.storyboardInitCompleted(StartAuthViewController.self) { (r, viewController) in
            viewController.router = r.resolve(AuthRouting.self, argument: viewController)
            viewController.viewModel = r.resolve(AuthViewModeling.self)
        }
        defaultContainer.storyboardInitCompleted(ChatsViewController.self) { (r, viewController) in
            viewController.router = r.resolve(ChatsRouting.self, argument: viewController)
            viewController.viewModel = r.resolve(ChatsViewModeling.self)
        }
    }
    
}
