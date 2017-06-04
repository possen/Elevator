//
//  Elevator.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

// corresponds to up/down buttons on each floor.
class FloorPanel {
    public private(set) var upRequested = false
    public private(set) var downRequested = false
    private let name: String
    
    public func pressUp() {
        upRequested = true
    }
    
    public func pressDown() {
        downRequested = true
    }
    
    internal init(name: String) {
        self.name = name
    }
    
    internal func clear(direction : Elevator.Direction) {
        upRequested = false
        downRequested = false
    }
}
