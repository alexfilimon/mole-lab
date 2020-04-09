//
//  Actor.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

protocol Actor {
    var point: Point { get }
    func performAction()
}
