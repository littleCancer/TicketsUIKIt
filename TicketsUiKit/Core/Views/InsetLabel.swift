//
//  InsetLabel.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class InsetLabel: UILabel {

    let inset = UIEdgeInsets(top: -2, left: 45, bottom: -2, right: 2)

        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: inset))
        }

        override var intrinsicContentSize: CGSize {
            var intrinsicContentSize = super.intrinsicContentSize
            intrinsicContentSize.width += inset.left + inset.right
            intrinsicContentSize.height += inset.top + inset.bottom
            return intrinsicContentSize
        }

}
