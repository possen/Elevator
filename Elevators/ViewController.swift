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
        let elevatorController0 = ElevatorViewController( model: manager, index:0, stackView: elevator0)
        let elevatorController1 = ElevatorViewController( model: manager, index:1, stackView: elevator1)
        let elevatorController2 = ElevatorViewController( model: manager, index:2, stackView: elevator2)
        let elevatorController3 = ElevatorViewController( model: manager, index:3, stackView: elevator3)
        
        elevatorControllers = [elevatorController0, elevatorController1, elevatorController2, elevatorController3]
        
    }
}

