//
//  DiscountListViewCellTableViewCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import UIKit
import SDWebImage

class DiscountListTableCell: UITableViewCell {

    var discountCollectionView: UICollectionView?
    
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
        layout.itemSize = CGSize(width: 220 , height: 400)
        self.discountCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        discountCollectionView?.register(UINib(nibName: "DiscountCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.discountCollectionView?.backgroundColor = UIColor.appGray
        discountCollectionView?.showsHorizontalScrollIndicator = false
        discountCollectionView?.isHidden = false
        self.contentView.addSubview(discountCollectionView!)
        discountCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        discountCollectionView?.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: discountCollectionView!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: discountCollectionView!.trailingAnchor),
            self.topAnchor.constraint(equalTo: discountCollectionView!.topAnchor),
            self.bottomAnchor.constraint(equalTo: discountCollectionView!.bottomAnchor)
        ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        discountCollectionView?.delegate = dataSourceDelegate
        discountCollectionView?.dataSource = dataSourceDelegate
        discountCollectionView?.tag = row
        discountCollectionView?.reloadData()
    }
    
}
