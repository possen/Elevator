//
//  Elevator.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import Foundation

class Elevator {
    let timePerFloorInSeconds = 1

    enum Direction {
        case up
        case down
        case none
    }
    
    public let name: String
    public private(set) var currentFloor = 0
    public private(set) var direction = Direction.none
    public let door = Door()
    internal var inProgressToFloor : Int? = nil
    internal weak var manager : ElevatorManager! = nil
    
    init(name: String) {
        self.name = name
    }
    
    internal func visit() {
        inProgressToFloor = nil
        manager.visitNotify(floor: currentFloor, direction: direction)
        print("Visiting:", name, currentFloor)
        door.openRequest()
        door.closeRequest()
    }
    
    internal func moveTo(floor: Int) {
        guard door.state == .closed else {
            return
        }
        inProgressToFloor = floor
        direction = floor > currentFloor ? .up : .down
        let distance = abs(floor - currentFloor)
        
        for floor in direction == .down ? floor..<currentFloor : currentFloor..<floor {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timePerFloorInSeconds * floor)) {
                self.currentFloor = floor
                self.manager.updateNotify()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timePerFloorInSeconds * distance)) {
            self.currentFloor = floor
            self.visit()
            self.manager.updateNotify()
        }
    }
    
    // corresponds to button panel in elevator
    public func request(floor: Int) {
        manager.requestFloor(floor: floor)
    }
    
    class Door {
        
        let timeToChangeDoorStatedInSeconds = 1
        let timeBeforeDoorCloses = 2

        enum DoorState {
            case open
            case closed
        }
        
        public private(set) var state = DoorState.closed
        private var cancelClose = false
        
        // Door management, real doors would be more sophisticated with safety sensors etc. Door opening is never cancelled but
        // door closing needs to be cancelable. Also there would be an alarm if door is kept open too long.
        public func openRequest() {
            cancelClose = true
            changeState(.open)
        }
        
        public func closeRequest() {
            
            // close door after delay.
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeBeforeDoorCloses)) { [unowned self] in
                if self.cancelClose {
                    return
                }
                
                self.changeState(.closed)
            }
        }
        
        private func changeState(_ doorState : DoorState) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeToChangeDoorStatedInSeconds)) { [unowned self] in
                
                if self.cancelClose && doorState == .closed {
                    return
                }
                
                print("DoorState: \(doorState)")
                self.state = doorState
            }
        }
    }
}

