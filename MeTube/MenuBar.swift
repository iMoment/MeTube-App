//
//  MenuBar.swift
//  MeTube
//
//  Created by Stanley Pan on 8/30/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}