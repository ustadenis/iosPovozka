//
//  BaseViewController.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 12/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    public var segueHandler: ((UIStoryboardSegue, Any?) -> Void)?

}

extension BaseViewController: ViewController {
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueHandler?(segue, sender)
    }
    
}
