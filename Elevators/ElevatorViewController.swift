//
//  ElevatorViewController.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/28/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ElevatorViewController: UIViewController {
    
    init(model: ElevatorManager, index: Int, stackView: UIStackView) {
        super.init(nibName: nil, bundle: nil)
        
        let count = model.floorPanels.count
        for _ in 0..<count {
            stackView.addArrangedSubview( ElevatorView())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

