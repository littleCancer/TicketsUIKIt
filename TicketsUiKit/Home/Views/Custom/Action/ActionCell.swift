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
        styleSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func styleSubviews() {
        self.backgroundColor = UIColor.appGray
        let image = UIImage(systemName: "pencil.circle.fill")
        adminButton.setBackgroundImage(image, for: .normal)
    }
    
}
