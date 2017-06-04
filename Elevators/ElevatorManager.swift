//
//  Elevator.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

let totalFloors = 20
let totalElevators = 4

class ElevatorManager {
    internal let requests = FloorRequests()
    internal var updateNotify : () -> Void = {}
    internal let floorPanels = Array(0..<totalFloors).map { FloorPanel(name: "\($0)") }
    internal let elevators = Array(0..<totalElevators).map { Elevator(name: "\($0)") }
    
    internal var motionComplete : () -> Void = {}
    
    init() {
        for elevator in elevators {
            elevator.manager = self
            elevator.mustVisitRequestedFloors.requestNotify = requestNotify
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
            let mustVisit = elevator.mustVisitRequestedFloors.nearestRequestedFloor(from: elevator.currentFloor,
                                                                                    direction: elevator.direction)
            if let mustVisit = mustVisit {
                elevator.moveTo(floor:mustVisit)
            }
        }
        
        let distances : [(Elevator, Int, Int)] = elevators.flatMap { elevator in
            if let _ = elevator.inProgressToFloor  {
                return nil
            } else {
                let floor = requests.nearestRequestedFloor(from: elevator.currentFloor,
                                                                      direction: elevator.direction) ?? Int.max

                return (elevator, floor, abs(floor - elevator.currentFloor)) // distance
            }
        }
        
        let closest = distances.min { (tuple1, tuple2) -> Bool in
            return tuple1.2 < tuple2.2
        }
        
        if let (elevator, floor, _) = closest, floor != Int.max {
            requests.clearFloorRequest(floor: floor)
            elevator.moveTo(floor:floor)
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
        
        print("Request floor -> \(floor) \(direction)")
        requestFloor(floor: floor)
    }
}
