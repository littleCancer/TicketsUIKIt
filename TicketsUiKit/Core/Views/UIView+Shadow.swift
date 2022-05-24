//
//  UIView+Shadow.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

protocol ShadowableRoundableView {
    
    var cornerRadius: CGFloat { get set }
    var shadowColor: UIColor { get set }
    var shadowOffsetWidth: CGFloat { get set }
    var shadowOffsetHeight: CGFloat { get set }
    var shadowOpacity: Float { get set }
    var shadowRadius: CGFloat { get set }
    
    var shadowLayer: CAShapeLayer { get }
    
    func setCornerRadiusAndShadow()
}

extension UIView
{
    func setCornerRadiusAndShadow(cornerRadius: CGFloat, shadowColor: UIColor, shadowOffsetWidth: CGFloat, shadowOffsetHeight: CGFloat, shadowOpacity: Float, shadowRadius: CGFloat) {

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        let subView = UIView()
        
        self.superview?.insertSubview(subView, belowSubview: self)
        subView.frame = self.frame
        
        subView.layer.shadowPath = UIBezierPath(roundedRect: subView.bounds, cornerRadius: 10).cgPath
        subView.layer.shouldRasterize = true
        subView.layer.rasterizationScale = UIScreen.main.scale

        subView.backgroundColor = UIColor.clear
        subView.layer.shadowColor = shadowColor.cgColor
        subView.layer.shadowOpacity = shadowOpacity
        subView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        subView.layer.shadowRadius = shadowRadius
    }
}