//
//  ElevatorView.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/29/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ElevatorView: UIStackView {
    let layerRef : CALayer
    weak var manager : ElevatorManager! = nil
    var elevator : Elevator! = nil
    
    enum State {
        case onFloorDoorClosed
        case onFloorDoorOpen
        case notOnFloorOrRequested
        case specificElevatorRequest           
    }

    override init(frame: CGRect) {
        let floorPressView = UIButton(frame: frame)
        layerRef = floorPressView.layer
        layerRef.borderColor = UIColor.gray.cgColor
        layerRef.backgroundColor = UIColor.blue.cgColor
        layerRef.borderWidth = 2.0
        
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        addSubview(floorPressView)
        floorPressView.addTarget(self, action: #selector(floorPresssAction), for: .touchUpInside)
    }
    
    @objc func floorPresssAction(sender: Any) {
        print("elevator floor request \(tag) elevator \(elevator.name)")
        
        elevator.pressFloorButton(floor: tag)
    }

    func changeState(_ state: State) {
        switch state {
            case .onFloorDoorClosed:
                layerRef.backgroundColor = UIColor.yellow.cgColor
            case .onFloorDoorOpen:
                layerRef.backgroundColor = UIColor.black.cgColor
            case .notOnFloorOrRequested:
                layerRef.backgroundColor = UIColor.blue.cgColor
            case .specificElevatorRequest:
                layerRef.backgroundColor = UIColor.green.cgColor
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
