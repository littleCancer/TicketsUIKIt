//
//  RoundedText.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import UIKit

import Foundation
import SwiftUI
class RoundedText: UIView {
    
    var font: UIFont = UIFont(name: "Montserrat", size: 20)! {
        didSet {
            label.font = font
        }
    }
    var label: UILabel = UILabel()
    var text = "" {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .clear
        
        let background = UIView(frame: self.bounds)
        background.layer.cornerRadius = self.bounds.height / 2
        background.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        background.layer.masksToBounds = true;
        
        self.addSubview(background)
        self.addSubview(label)
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            self.topAnchor.constraint(equalTo: label.topAnchor),
            self.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
    }

}
