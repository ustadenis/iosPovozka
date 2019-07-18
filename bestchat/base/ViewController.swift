//
//  ViewControllerProtocol.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 13/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

public protocol ViewController: class {
    
    var segueHandler: ((UIStoryboardSegue, Any?) -> Void)? { get set }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
}
