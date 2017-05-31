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
    var elevatorManager : ElevatorManager!
    let elevatorIndex : Int
    let elevatorModel : Elevator
    
    init(manager: ElevatorManager, index: Int, stackView: UIStackView) {
        self.elevatorManager = manager
        self.elevatorIndex = index
        self.elevatorModel = elevatorManager.elevators[index]

        super.init(nibName: nil, bundle: nil)
        
        for floor in 0..<manager.floorPanels.count {
            let frame = CGRect(x: 0,
                               y: CGFloat(floor) * 10.0,
                               width: stackView.frame.size.width,
                               height: 10.0)

            let elevatorView = ElevatorView(frame: frame)
            elevatorView.tag = floor
            elevatorView.manager = manager
            elevatorViews.append(elevatorView)
            stackView.addArrangedSubview(elevatorView)
        }
    }
    
    func update() {
        let count = elevatorManager.floorPanels.count - 1
        
        for floor in 0..<count {
            
            var state = ElevatorView.State.notOnFloor
            
            if floor == elevatorModel.currentFloor {
                state = elevatorModel.door.state == .open ? .onFloorDoorOpen :.onFloorDoorClosed
            }
            
            elevatorViews[count - floor].changeState(state)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

