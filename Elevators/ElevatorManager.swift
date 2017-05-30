//
//  Elevator.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

class ElevatorManager {
    let requests = FloorRequests()
    let floorPanels = Array(0..<20).map { FloorPanel(name: "\($0)") }
    let elevators = Array(0..<4).map { Elevator(name: "\($0)") }
    
    internal var motionComplete : () -> Void = {}
    
    init() {
        for elevator in elevators {
            elevator.manager = self
        }
        requests.visitNotify = visitNotify
        requests.requestNotify = requestNotify
    }
    
    internal func visitNotify(floor: Int, direction: Elevator.Direction) {
        requests.clearFloorRequest(floor: floor)
        floorPanels[floor].clear(direction: direction)
        
        let inProgress = elevators.reduce (false) { $0 || $1.inProgressToFloor != nil }
        
        if !inProgress {
            motionComplete()
        }
    }
    
    internal func requestNotify() {
        for elevator in elevators {
            if let _ = elevator.inProgressToFloor {} else {
                if let floor = requests.nearestRequestedFloor(from: elevator.currentFloor,
                                                              direction: elevator.direction) {
                    requests.clearFloorRequest(floor: floor)
                    elevator.moveTo(floor:floor)
                }
                break
            }
        }
    }
    
    internal func requestFloor(floor: Int) {
        requests.makeRequest(floor: floor)
    }
    
    public func floorButtonPress(floor: Int, direction: Elevator.Direction)  {
        
        let floor = floor.restrictRange(lower:0, upper: floorPanels.count - 1)
        
        switch direction {
        case .up:
            floorPanels[floor].pressUp()
        case .down:
            floorPanels[floor].pressDown()
        default:
            break
        }
        
        requestFloor(floor: floor)
    }
}
