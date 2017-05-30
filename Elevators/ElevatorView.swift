//
//  ElevatorView.swift
//  Elevators
//
//  Created by Paul Ossenbruggen on 5/29/17.
//  Copyright © 2017 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ElevatorView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.backgroundColor = (UIColor.blue as! CGColor)
        layer.borderColor = (UIColor.brown as! CGColor)
        layer.borderWidth = 2.0
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
