//
//  ActionButtonsCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import UIKit

class ActionButtonsCell: UITableViewCell {

    @IBOutlet weak var resetStateButton: UIButton!
    @IBOutlet weak var addEventButton: UIButton!
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
    
        let resetImage = UIImage(systemName: "minus.rectangle.fill")
        resetStateButton.setBackgroundImage(resetImage, for: .normal)
        
        let addImage =  UIImage(systemName: "plus")
        addEventButton.setBackgroundImage(addImage, for: .normal)
        
        
    }
    
}
