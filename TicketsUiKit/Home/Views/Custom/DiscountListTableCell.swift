//
//  DiscountListViewCellTableViewCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import UIKit
import SDWebImage

class DiscountListTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var discountCollectionView: UICollectionView?
    
    var discounts:[DiscountEntity] = [] {
        didSet {
            discountCollectionView?.reloadData()
        }
    }
    
    var layout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
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
        layout.itemSize = CGSize(width: 200 , height: 400)
        self.discountCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        discountCollectionView!.delegate = self
        discountCollectionView!.dataSource = self
        discountCollectionView?.register(UINib(nibName: "DiscountCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        discountCollectionView!.showsHorizontalScrollIndicator = false
        discountCollectionView?.isHidden = false
        discountCollectionView?.tag = 2
//        discountCollectionView.tag = 1
        self.addSubview(discountCollectionView!)
        discountCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: discountCollectionView!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: discountCollectionView!.trailingAnchor),
            self.topAnchor.constraint(equalTo: discountCollectionView!.topAnchor),
            self.bottomAnchor.constraint(equalTo: discountCollectionView!.bottomAnchor)
        ])
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let disount = discounts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DiscountCell ?? DiscountCell()
        
        cell.eventImage.sd_setImage(with: URL(string: ApiUtils.getImageUrl(imagePath: disount.photo ?? "")))
        cell.name.text = disount.name
        cell.date.text = FormatUtils.formatDate(date: disount.date ?? Date.now)
        cell.promoText.text = FormatUtils.formatTicketsLeftMessage(quantity: disount.quantity)
        cell.roundText.text = FormatUtils.formatDiscount(discount: disount.discount)
        cell.location.text = disount.place
        
        return cell
    }
    
}
