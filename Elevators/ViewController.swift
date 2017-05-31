//
//  ViewController.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var manager: ElevatorManager!
    var elevatorControllers : [ElevatorViewController] = []

    @IBOutlet weak var elevator0: UIStackView!
    @IBOutlet weak var elevator1: UIStackView!
    @IBOutlet weak var elevator2: UIStackView!
    @IBOutlet weak var elevator3: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = ElevatorManager()
        
        // since these are IBOutlets can't map them, link them with the associated views.
        let elevatorController0 = ElevatorViewController( manager: manager, index:0, stackView: elevator0)
        let elevatorController1 = ElevatorViewController( manager: manager, index:1, stackView: elevator1)
        let elevatorController2 = ElevatorViewController( manager: manager, index:2, stackView: elevator2)
        let elevatorController3 = ElevatorViewController( manager: manager, index:3, stackView: elevator3)
        
        elevatorControllers = [elevatorController0, elevatorController1, elevatorController2, elevatorController3]
        
        _ = elevatorControllers.map { $0.update() }
        
        manager.motionComplete = {
            print("movements complete")
            _ = self.elevatorControllers.map { $0.update() }
        }
        
        manager.updateNotify = {
            _ = self.elevatorControllers.map { $0.update() }
        }

        manager.floorButtonPress(floor: 3, direction: .up)
        manager.floorButtonPress(floor: 19, direction: .up)
        manager.floorButtonPress(floor: 5, direction: .down)

    }
}

