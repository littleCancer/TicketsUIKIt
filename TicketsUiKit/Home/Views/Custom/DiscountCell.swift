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
        
        eventImage.layer.cornerRadius = 25
        eventImage.layer.shadowColor = UIColor.gray.cgColor
        eventImage.layer.shadowOpacity = 1
        eventImage.layer.shadowOffset = CGSize(width: 0, height: 20)
        eventImage.layer.shadowRadius = 10
        eventImage.layer.masksToBounds = true
        eventImage.contentMode = .scaleAspectFill
        
        bottomView.layer.cornerRadius = 25
    }

}
