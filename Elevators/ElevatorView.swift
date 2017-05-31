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
    
    enum State {
        case onFloorDoorClosed
        case onFloorDoorOpen
        case notOnFloor
    }

    override init(frame: CGRect) {
        let view = UIView(frame: frame)
        layerRef = view.layer
        layerRef.borderColor = UIColor.gray.cgColor
        layerRef.backgroundColor = UIColor.white.cgColor
        layerRef.borderWidth = 2.0
        
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        addSubview(view)
        
        let size = CGSize(width: frame.size.width / 2, height: frame.size.height)
        let rightOrigin = CGPoint(x: frame.origin.x + frame.size.width / 2, y: frame.origin.y)
        let leftFrame = CGRect(origin: frame.origin, size: size)
        let rightFrame = CGRect(origin: rightOrigin, size: size)
       
        let up = UIButton(frame: leftFrame)
        let down = UIButton(frame: rightFrame)
        up.titleLabel?.text = "•"
        up.titleLabel?.textAlignment = .center
        
        up.addTarget(self, action: #selector(upAction), for: .touchUpInside)
        down.addTarget(self, action: #selector(downAction), for: .touchUpInside)

        addSubview(up)
        addSubview(down)
    }
    
    func upAction(sender: Any) {
        print("up \(tag)")
        manager.floorButtonPress(floor: tag, direction: .up)
    }
    
    func downAction(sender: Any) {
        print("down \(tag)")
        manager.floorButtonPress(floor: tag, direction: .down)
    }

    func changeState(_ state: State) {
        switch state {
            case .onFloorDoorClosed:
                layerRef.backgroundColor = UIColor.yellow.cgColor
            case .onFloorDoorOpen:
                layerRef.backgroundColor = UIColor.black.cgColor
            case .notOnFloor:
                layerRef.backgroundColor = UIColor.blue.cgColor
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
