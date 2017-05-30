//
//  ElevatorsTests.swift
//  ElevatorsTests
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import XCTest

@testable import Elevators

class ElevatorsTests: XCTestCase {
    var manager : ElevatorManager!
    
    override func setUp() {
        super.setUp()
        manager = ElevatorManager()
    }
    
    func testFloorMoveStart1() {
        let exp = expectation(description: "testFloorMove1")
        
        manager.motionComplete = {
            exp.fulfill()
        }
        
        manager.floorButtonPress(floor: 2, direction: Elevator.Direction.up)
        
        XCTAssertEqual(manager.floorPanels.map { $0.upRequested },
                       [false, false, true, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
        
        XCTAssertEqual(manager.floorPanels.map { $0.downRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
      
        wait(for:[exp], timeout:40)
        
        XCTAssertEqual(manager.elevators.map { $0.currentFloor }, [2, 0, 0, 0])
        
        XCTAssertEqual(manager.floorPanels.map { $0.upRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
        
        XCTAssertEqual(manager.floorPanels.map { $0.downRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])

    }
   
    func testFloorMoveStart2() {
        
        let exp = expectation(description: "testFloorMove2")
        
        manager.motionComplete = {
            exp.fulfill()
        }
        
        manager.floorButtonPress(floor: 1, direction: Elevator.Direction.up)
        manager.floorButtonPress(floor: 3, direction: Elevator.Direction.up)
        
        XCTAssertEqual(manager.floorPanels.map { $0.upRequested },
                       [false, true, false, true, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
        
        XCTAssertEqual(manager.floorPanels.map { $0.downRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])

        wait(for:[exp], timeout:40)
        
        XCTAssertEqual(manager.elevators.map { $0.currentFloor }, [1, 3, 0, 0])
        
        XCTAssertEqual(manager.floorPanels.map { $0.upRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
        
        XCTAssertEqual(manager.floorPanels.map { $0.downRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])

    }

    func testFloorMoveDown2() {
        let exp = expectation(description: "testFloorMove2")
        
        manager.motionComplete = {
            exp.fulfill()
        }
        
        manager.floorButtonPress(floor: 3, direction: Elevator.Direction.up)
        manager.floorButtonPress(floor: 19, direction: Elevator.Direction.up)
        manager.floorButtonPress(floor: 5, direction: Elevator.Direction.down)

        XCTAssertEqual(manager.floorPanels.map { $0.upRequested },
                       [false, false, false, true, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, true])
        
        XCTAssertEqual(manager.floorPanels.map { $0.downRequested },
                       [false, false, false, false, false, true, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
        
        wait(for:[exp], timeout:40)
        
        XCTAssertEqual(manager.elevators.map { $0.currentFloor }, [3, 19, 5, 0])
        
        XCTAssertEqual(manager.floorPanels.map { $0.upRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
        
        XCTAssertEqual(manager.floorPanels.map { $0.downRequested },
                       [false, false, false, false, false, false, false, false, false, false,
                        false, false, false, false, false, false, false, false, false, false])
    }
}
