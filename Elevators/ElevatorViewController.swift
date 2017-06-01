//
//  ElevatorViewController.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ElevatorViewController: UIViewController {
    var elevatorViews : [ElevatorView] = []
    var manager : ElevatorManager!
    let elevatorIndex : Int
    let elevator : Elevator
    let maxFloor : Int
    
    init(manager: ElevatorManager, index: Int, stackView: UIStackView) {
        self.manager = manager
        self.elevatorIndex = index
        self.elevator = manager.elevators[index]
        maxFloor = manager.floorPanels.count - 1

        super.init(nibName: nil, bundle: nil)
        
        for (floor, _) in manager.floorPanels.enumerated().reversed() {
            let frame = CGRect(x: 0,
                               y: 0,
                               width: stackView.frame.size.width,
                               height: 18.0)

            let elevatorView = ElevatorView(frame: frame)
            elevatorView.elevator = elevator
            elevatorView.tag = floor
            elevatorView.manager = manager
            
            elevatorViews.append(elevatorView)
            stackView.addArrangedSubview(elevatorView)
        }
    }
    
    func update() {
        for elevatorPanel in elevatorViews {
            var state = ElevatorView.State.notOnFloorOrRequested
            
            if elevatorPanel.tag == elevator.currentFloor {
                state = elevator.door.state == .open ? .onFloorDoorOpen : .onFloorDoorClosed
            } else if manager.elevators[elevatorIndex].mustVisitRequestedFloors.requestedFloors[elevatorPanel.tag] {
                state = .specificElevatorRequest
            }
            
            elevatorPanel.changeState(state)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

