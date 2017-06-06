//
//  ElevatorView.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/29/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class FloorPanelView: UIStackView {
    let layerRef : CALayer
    weak var manager : ElevatorManager! = nil
    let up : UIButton
    let down : UIButton
    var model : FloorPanel! = nil
        
    override init(frame: CGRect) {
        let view = UIView(frame: frame)
        layerRef = view.layer
        layerRef.borderColor = UIColor.lightGray.cgColor
        layerRef.backgroundColor = UIColor.white.cgColor
        layerRef.borderWidth = 2.0

        let size = CGSize(width: frame.size.width / 2, height: frame.size.height)
        let rightOrigin = CGPoint(x: frame.origin.x + frame.size.width / 2, y: frame.origin.y)
        let leftFrame = CGRect(origin: frame.origin, size: size)
        let rightFrame = CGRect(origin: rightOrigin, size: size)

        up = UIButton(frame: leftFrame)
        down = UIButton(frame: rightFrame)
        
        super.init(frame: frame)
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
     
        up.layer.borderColor = UIColor.lightGray.cgColor
        down.layer.borderColor = UIColor.lightGray.cgColor
       
        up.layer.borderWidth = 1.0
        down.layer.borderWidth = 1.0
        
        up.setImage(UIImage(named: "1uparrow"), for: .normal)
        down.setImage(UIImage(named: "1downarrow"), for: .normal)
        
        up.addTarget(self, action: #selector(upAction), for: .touchUpInside)
        down.addTarget(self, action: #selector(downAction), for: .touchUpInside)
        
        addSubview(up)
        addSubview(down)
    }
    
    func update() {
        up.isEnabled = !model.upRequested
        down.isEnabled = !model.downRequested
    }

    @objc func upAction(sender: Any) {
        print("up \(tag)")
        manager.floorButtonPress(floor: tag, direction: .up)
    }
    
    @objc func downAction(sender: Any) {
        print("down \(tag)")
        manager.floorButtonPress(floor: tag, direction: .down)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
