//
//  FilterByCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import UIKit

class FilterByCell: UITableViewCell {

    @IBOutlet weak var discountsButton: UIButton!
    @IBOutlet weak var buttonsContainer: UIView!
    @IBOutlet weak var nonDiscountsButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        styleContainer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func styleContainer() {
        self.backgroundColor = UIColor.appGray
        self.buttonsContainer.backgroundColor = UIColor.appBlue
        
        self.buttonsContainer.layer.cornerRadius = buttonsContainer.bounds.self.height / 2
        self.buttonsContainer.layer.masksToBounds = true
        self.nonDiscountsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.discountsButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

}
