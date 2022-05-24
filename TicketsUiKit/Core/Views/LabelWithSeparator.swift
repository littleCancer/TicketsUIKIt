//
//  LabelWithSeparator.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class LabelWithSeparator: UILabel {

    let separator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        
        self.addSubview(separator)
        separator.backgroundColor = UIColor.gray
        separator.frame = self.bounds
        self.backgroundColor = UIColor.red
        

        
    }
    
}
