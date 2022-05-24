//
//  ExpiredEventViewCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class ExpiredEventViewCell: UICollectionViewCell {

    @IBOutlet weak var nameView: RoundedText!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var discounntView: RoundedText!
    @IBOutlet weak var eventImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.appGray
        discounntView.font = UIFont.appFontOfSize(size: 25)!
        eventImage.setCornerRadiusAndShadow(cornerRadius: 30, shadowColor: UIColor.gray, shadowOffsetWidth: 5, shadowOffsetHeight: 50, shadowOpacity: 0.15, shadowRadius: 4)
        
        eventImage.contentMode = .scaleAspectFill
    }

}
