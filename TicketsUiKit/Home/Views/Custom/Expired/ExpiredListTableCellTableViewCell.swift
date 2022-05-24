//
//  ExpiredListTableCellTableViewCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class ExpiredListTableCellTableViewCell: UITableViewCell {
    
    var expiredEventsCollection: UICollectionView?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
            
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200 , height: 240)
        self.expiredEventsCollection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        expiredEventsCollection?.register(UINib(nibName: "ExpiredEventViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.expiredEventsCollection?.backgroundColor = UIColor.appGray
        expiredEventsCollection?.showsHorizontalScrollIndicator = false
        expiredEventsCollection?.isHidden = false
        self.contentView.addSubview(expiredEventsCollection!)
        expiredEventsCollection?.translatesAutoresizingMaskIntoConstraints = false
        expiredEventsCollection?.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: expiredEventsCollection!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: expiredEventsCollection!.trailingAnchor),
            self.topAnchor.constraint(equalTo: expiredEventsCollection!.topAnchor),
            self.bottomAnchor.constraint(equalTo: expiredEventsCollection!.bottomAnchor)
        ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        expiredEventsCollection?.delegate = dataSourceDelegate
        expiredEventsCollection?.dataSource = dataSourceDelegate
        expiredEventsCollection?.tag = row
        expiredEventsCollection?.reloadData()
    }
    
}
