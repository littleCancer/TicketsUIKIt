//
//  DiscountCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import UIKit

class DiscountCell: UICollectionViewCell {

    @IBOutlet weak var roundText: RoundedText!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var promoText: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.appGray
        roundText.font = UIFont.appFontOfSize(size: 25)!
        eventImage.setCornerRadiusAndShadow(cornerRadius: 30, shadowColor: UIColor.gray, shadowOffsetWidth: 10, shadowOffsetHeight: 70, shadowOpacity: 0.4, shadowRadius: 15)
        
        eventImage.contentMode = .scaleAspectFill
        bottomView.layer.cornerRadius = 30
        

    }
    
}
