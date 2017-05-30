//
//  Elevator.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

extension Int {
    func restrictRange(lower: Int, upper: Int) -> Int {
        let val = Swift.max(lower, self) // "Swift." to get global function.
        return Swift.min(upper, val)
    }
}
