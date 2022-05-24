//
//  UpcomingEventViewTableViewCell.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class UpcomingEventViewTableViewCell: UITableViewCell {
    
    var eventView: EventView?
    
    var event: EventEntity? {
        didSet {
            updateDetails()
        }
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
        self.contentView.backgroundColor = UIColor.appGray
        eventView = EventView(frame: self.bounds)
        if let eventView = eventView {
            self.contentView.addSubview(eventView)
            eventView.translatesAutoresizingMaskIntoConstraints = false
            eventView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            eventView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            eventView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            eventView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            eventView.eventImage.layer.cornerRadius = 30
            eventView.eventImage.layer.masksToBounds = true
            eventView.priceView.font = UIFont.appFontOfSize(size: 25)!
            
            eventView.backgroundView.setCornerRadiusAndShadow(cornerRadius: 30, shadowColor: UIColor.gray, shadowOffsetWidth: 0, shadowOffsetHeight: 8, shadowOpacity: 0.6, shadowRadius: 15)
        }
    }
    
    func updateDetails() {
        
        eventView?.eventImage.sd_setImage(with: URL(string: ApiUtils.getImageUrl(imagePath: (event?.photo)!)))
        eventView?.discountView.isHidden = true
        eventView?.locationLabel.text = event?.place
        
        if let date = event?.date {
            eventView?.dayLabel.text = FormatUtils.dayOfTheMonthFromDate(date: date)
            eventView?.monthLabel.text = FormatUtils.monthFromDate(date: date)
            eventView?.timeLabel.text = FormatUtils.timeFromDate(date: date)
            eventView?.yearLabel.text = FormatUtils.yearFromDate(date: date)
        }
        
        eventView?.nameView.text = event?.name ?? ""
        eventView?.priceView.text = FormatUtils.formatPrice(price: event?.price)
        eventView?.ticketsLeftLabel.text = FormatUtils.formatTicketsLeftMessage(quantity: event?.quantity)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
