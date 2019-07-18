//
//  ChatsRouter.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 13/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import UIKit

public protocol AuthRouting {
    func openChats()
}

public class AuthRouter: BaseRouter {
    private enum Segue: String {
        case chatsSegue
    }
}

extension AuthRouter: AuthRouting {
    
    public func openChats() {
        guard let vc = viewController as? UIViewController else {
            fatalError()
        }
        vc.performSegue(withIdentifier: Segue.chatsSegue.rawValue, sender: vc)
    }
    
}
