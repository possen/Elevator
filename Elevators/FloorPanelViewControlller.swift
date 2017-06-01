//
//  FloorPanelViewController.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class FloorPanelViewController: UIViewController {
    var floorViews : [FloorPanelView] = []
    var manager : ElevatorManager!
    let maxFloor : Int
    
    init(manager: ElevatorManager, stackView: UIStackView) {
        self.manager = manager
        maxFloor = manager.floorPanels.count - 1
       
        super.init(nibName: nil, bundle: nil)
        
        for (floor, floorPanel) in manager.floorPanels.enumerated().reversed() {
            let frame = CGRect(x: 0,
                               y: 0,
                               width: stackView.frame.size.width,
                               height: 18.0)
            
            let floorView = FloorPanelView(frame: frame)
            floorView.model = floorPanel
            floorView.tag = floor
            floorView.manager = manager
            floorViews.append(floorView)
            stackView.addArrangedSubview(floorView)
        }
    }
    
    func update() {
        for floorView in floorViews {
            floorView.update()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

