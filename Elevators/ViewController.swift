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
    var floorPanelController : FloorPanelViewController! = nil
    var elevatorDirection : [ (UIButton, UIButton) ] = []
    
    @IBOutlet weak var floorPanel: UIStackView!

    @IBOutlet weak var elevator0: UIStackView!
    @IBOutlet weak var elevator1: UIStackView!
    @IBOutlet weak var elevator2: UIStackView!
    @IBOutlet weak var elevator3: UIStackView!
    
    @IBOutlet weak var up0: UIButton!
    @IBOutlet weak var down0: UIButton!
    @IBOutlet weak var up1: UIButton!
    @IBOutlet weak var down1: UIButton!
    @IBOutlet weak var up2: UIButton!
    @IBOutlet weak var down2: UIButton!
    @IBOutlet weak var up3: UIButton!
    @IBOutlet weak var down3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = ElevatorManager()
        
        floorPanelController = FloorPanelViewController(manager: manager, stackView: floorPanel)
        
        // since these are IBOutlets can't map them, link them with the associated views.
        let elevatorController0 = ElevatorViewController( manager: manager, index:0, stackView: elevator0)
        let elevatorController1 = ElevatorViewController( manager: manager, index:1, stackView: elevator1)
        let elevatorController2 = ElevatorViewController( manager: manager, index:2, stackView: elevator2)
        let elevatorController3 = ElevatorViewController( manager: manager, index:3, stackView: elevator3)
        
        elevatorControllers = [elevatorController0, elevatorController1, elevatorController2, elevatorController3]
        
        elevatorDirection = [(up0, down0), (up1, down1), (up2, down2), (up3, down3)]
        _ = elevatorDirection.map { (up, down) in up.isUserInteractionEnabled = false; down.isUserInteractionEnabled = false }
        
        update()
        
        manager.motionComplete = {
            print("movements complete")
            self.update()
        }
        
        manager.updateNotify = {
            self.update()
        }
    }

    func update() {
        _ = elevatorControllers.map { $0.update() }
        _ = floorPanelController.update()
        _ = elevatorDirection.enumerated().map { (index, tuple ) in
            let up = tuple.0; let down = tuple.1
            let elevator = self.manager.elevators[index]
            let direction = elevator.direction
            
            up.isHighlighted = direction == .up
            down.isHighlighted = direction == .down
        }
    }
}




