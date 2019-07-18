//
//  StartAuthViewController.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 16/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit
import RxSwift
import Firebase
import FirebaseUI

class StartAuthViewController: BaseViewController {
    
    public var router: AuthRouting?
    public var viewModel: AuthViewModeling?
    
    private lazy var authUI: FUIAuth? = FUIAuth.defaultAuthUI()
    
    private var authStateDisposable: Disposable?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.subscribe()
        
        authStateDisposable = viewModel?.authState
            .subscribe({ [weak self] (authEvent) in
                if let auth = authEvent.element {
                    if auth.currentUser == nil {
                        self?.startAuth(auth: auth)
                    } else {
                        self?.router?.openChats()
                    }
                }
            })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.unsubscribe()
        
        authStateDisposable?.dispose()
    }
    
    private func startAuth(auth: Auth) {
        guard let providers = viewModel?.getListOfIDPs(authUI: authUI) else {
            fatalError()
        }
        
        self.authUI?.providers = providers
        
        let providerID = self.authUI?.providers.first?.providerID;
        let isPhoneAuth = providerID == PhoneAuthProviderID;
        let isEmailAuth = providerID == EmailAuthProviderID;
        let shouldSkipAuthPicker = self.authUI?.providers.count == 1 && (isPhoneAuth || isEmailAuth);
        if (shouldSkipAuthPicker) {
            if (isPhoneAuth) {
                let provider = self.authUI?.providers.first as! FUIPhoneAuth;
                provider.signIn(withPresenting: self, phoneNumber: nil);
            } else if (isEmailAuth) {
                let provider = self.authUI?.providers.first as! FUIEmailAuth;
                provider.signIn(withPresenting: self, email: nil);
            }
        } else {
            let controller = self.authUI!.authViewController()
            self.present(controller, animated: true, completion: nil)
        }
    }
    
}
