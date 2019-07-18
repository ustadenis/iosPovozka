//
//  BaseRouter.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 13/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

public class BaseRouter {
    
    weak var viewController: ViewController?
    
    init(with viewController: ViewController) {
        self.viewController = viewController
        self.viewController?.segueHandler = { [weak self] (segue, sender) in
            self?.prepare(for: segue, sender: sender)
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // no-op
    }

}
