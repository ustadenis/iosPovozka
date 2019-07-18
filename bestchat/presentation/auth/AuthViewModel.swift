//
//  ChatsViewModel.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 13/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FirebaseUI

public protocol AuthViewModeling {
    
    var authState: PublishSubject<Auth> { get }
    
    func subscribe()
    func unsubscribe()
    
    func getListOfIDPs(authUI: FUIAuth?) -> [FUIAuthProvider]
    
}

public class AuthViewModel {
    
    public var authState: PublishSubject<Auth> = PublishSubject.init()
    
    private lazy var auth: Auth = Auth.auth()
    
    private var authStateDidChangeHandle: AuthStateDidChangeListenerHandle?
    
    private func authStateChanged(auth: Auth, user: User?) {
        authState.onNext(auth)
    }
    
}

extension AuthViewModel: AuthViewModeling {
    
    public func subscribe() {
        self.authStateDidChangeHandle =
            self.auth.addStateDidChangeListener(self.authStateChanged(auth:user:))
        
        authState.onNext(auth)
    }
    
    public func unsubscribe() {
        if let handle = self.authStateDidChangeHandle {
            self.auth.removeStateDidChangeListener(handle)
        }
    }
    
    public func getListOfIDPs(authUI: FUIAuth?) -> [FUIAuthProvider] {
        var providers = [FUIAuthProvider]()
        
        providers.append(FUIEmailAuth())
        providers.append(FUIFacebookAuth())
        providers.append(FUIPhoneAuth(authUI: authUI!))
        
        return providers
    }
    
}
