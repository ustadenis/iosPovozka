//
//  Parser.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 15/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

protocol Parser {
    
    associatedtype TSource
    associatedtype TTarget
    
    func parse(source: TSource) -> TTarget
    
}
