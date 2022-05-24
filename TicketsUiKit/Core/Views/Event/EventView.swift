//
//  EventView.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import UIKit

class EventView: UIView {


    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameView: RoundedText!
    @IBOutlet weak var discountView: RoundedText!
    @IBOutlet weak var priceView: RoundedText!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ticketsLeftLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    static let nibName = "EventView"
    var contentView: UIView!
    
    class func instanceFromNib() -> EventView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EventView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func commonInit() {
        guard let view = loadViewFromNibe() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNibe() -> UIView? {
        let nib = UINib(nibName: EventView.nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: EventView.self)
        contentView = UINib(nibName: EventView.nibName, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
    
}
