//
//  UIViewController.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: DetailsViewModel?
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventDetailsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        styleSubviews()
    }
    
    private func styleSubviews() {
        
        self.view.backgroundColor = UIColor.appGray
        let titleLabel = UILabel()
        titleLabel.text = "Details"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appBoldFontOfSize(size: 22)
        self.navigationItem.titleView = titleLabel
        
        setCustomBack()

        self.view.backgroundColor = UIColor.appGray
        let tableBackground = UIView(frame: eventDetailsTable.bounds)
        self.eventDetailsTable.backgroundColor = UIColor.clear
        tableBackground.backgroundColor = UIColor.white
        tableBackground.setCornerRadiusAndShadow(cornerRadius: 25, shadowColor: UIColor.green, shadowOffsetWidth: -1, shadowOffsetHeight: 20, shadowOpacity: 0.8, shadowRadius: 30)
        self.eventDetailsTable.backgroundView = tableBackground
        self.eventDetailsTable.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 5, right: 0)
        
        if let imageUrl = viewModel?.eventPresentationModel.imageUrl {
            self.eventImageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
    
    
    // MARK: UITableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.cells[indexPath.row].getRowHeight() ?? 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }

        let cellType = viewModel.cells[indexPath.row]
        switch(cellType) {
            
        case .name:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "title-cell", for: indexPath) as? TitleCell ?? TitleCell()
            titleCell.titleLabel.text = cellType.getValue(model: viewModel.eventPresentationModel)
            return titleCell
        case .description:
            let descCell = tableView.dequeueReusableCell(withIdentifier: "desc-cell", for: indexPath) as? EventDescriptionCell ?? EventDescriptionCell()
            descCell.descriptionLabel.text = cellType.getValue(model: viewModel.eventPresentationModel)
            return descCell
        default:
            let detailLabel = tableView.dequeueReusableCell(withIdentifier: "detail-cell", for: indexPath) as? EventDetailCell ?? EventDetailCell()
            detailLabel.typeLabel.text = cellType.getTypeDescription()
            detailLabel.detailLabel.text = cellType.getValue(model: viewModel.eventPresentationModel)
            return detailLabel
        }
        
    }
    
    
}
