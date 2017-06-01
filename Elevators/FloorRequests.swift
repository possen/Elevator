//
//  Elevator.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

class FloorRequests {
    internal var requestNotify : () -> Void = {}
    internal var visitNotify : (Int, Elevator.Direction) -> Void = { floor in }
    internal var requestedFloors = [Bool](repeating: false, count: totalFloors)
    
    internal func makeRequest(floor : Int) {
        requestedFloors[floor] = true
        requestNotify()
    }
    
    internal func nearestRequestedFloor(from floor: Int, direction:Elevator.Direction) -> Int? {
        var indexSearchOrder : [Int]
        let floor = floor.restrictRange(lower:0, upper: requestedFloors.count - 1)
        
        switch direction {
        case .up, .none: // if no direction assume up
            indexSearchOrder = Array<Int>(floor..<requestedFloors.count) + Array<Int>(0..<floor).reversed()
        case .down:
            indexSearchOrder = Array<Int>(0..<floor).reversed() + Array<Int>(floor..<requestedFloors.count)
        }
        
        print("Search order", indexSearchOrder, direction)
        
        for floor in indexSearchOrder {
            let nearestRequested = requestedFloors[floor]
            if nearestRequested {
                print("Resolved floor:", floor)
                return floor
            }
        }
        
        return nil
    }
    
    internal func clearFloorRequest(floor: Int) {
        requestedFloors[floor] = false
    }
}

