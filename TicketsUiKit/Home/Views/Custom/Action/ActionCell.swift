//
//  ActionCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var adminButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.appGray
        let image = UIImage(systemName: "pencil.circle.fill") as UIImage?
        adminButton.setBackgroundImage(image, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
