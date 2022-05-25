//
//  AdminEventCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import UIKit

class AdminEventCell: UITableViewCell {

    @IBOutlet weak var buttonsContainer: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var eventView: EventView!

    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func styleSubviews() {
        
        self.backgroundColor = UIColor.appGray
        
        buttonsContainer.backgroundColor = UIColor.appBlue
        buttonsContainer.setCornerRadiousAndBottomShadow(cornerRadius: 30, shadowColor: UIColor.gray, shadowSize: 50, shadowOpacity: 0.2, shadowRadius: 4)
        
        
        eventView.layer.cornerRadius = 30
        eventView.layer.masksToBounds = true
        
        eventView.eventImage.contentMode = .scaleAspectFill
        eventView.eventImage.layer.cornerRadius = 30
        eventView.eventImage.layer.masksToBounds = true
        
        self.eventView.backgroundView.frame = self.eventView.bounds
        
        eventView.discountView.font = UIFont.appFontOfSize(size: 15)!
        
        self.eventView.updateConstraintsToFillParent()
    }

}
