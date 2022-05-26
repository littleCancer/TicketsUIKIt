//
//  AdminViewController.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import UIKit
import Combine

class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var adminTable: UITableView!
    
    var viewModel: AdminViewModel?
    var pairsToPresent: [EventDiscountPair] = []
    private var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = AdminViewModel(context: PersistenceController.shared.container.newBackgroundContext())
        setUpObserving()
        styleSubviews()
    }
    
    private func styleSubviews() {
        self.view.backgroundColor = UIColor.appGray
        
        self.view.backgroundColor = UIColor.appGray
        let titleLabel = UILabel()
        titleLabel.text = "Admin"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appBoldFontOfSize(size: 22)
        self.navigationItem.titleView = titleLabel
        
        setCustomBack()
    }
    
    private func setUpObserving() {
        
        viewModel?.$eventDiscountPairs.sink { [weak self] pairs in
            self?.loadData(newPairs: pairs, selectedTab: self?.viewModel?.selectedTab ?? SelectedAdminTab.NonDiscount)
        }.store(in: &cancellableSet)
        
        viewModel?.$selectedTab.sink { [weak self] selectedTab in
            self?.loadData(newPairs: self?.viewModel?.eventDiscountPairs ?? [], selectedTab: selectedTab)
        }.store(in: &cancellableSet)
        
    }
    
    
    private func loadData(newPairs: [EventDiscountPair], selectedTab: SelectedAdminTab) {
        if selectedTab == .Discount {
            self.pairsToPresent = newPairs.filter{ pair in
                return pair.discount != nil
            }
        } else {
            self.pairsToPresent = newPairs
        }
        
        UIView.transition(with: adminTable,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.adminTable.reloadData() })

    }
    
    // MARK: UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case AdminSection.filter.getSectionIndex():
            return 1
        case AdminSection.events.getSectionIndex():
            return self.pairsToPresent.count
        case AdminSection.action.getSectionIndex():
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case AdminSection.events.getSectionIndex():
            return 300
        default:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case AdminSection.filter.getSectionIndex():
            let filterCell = tableView.dequeueReusableCell(withIdentifier: "filter-cell", for: indexPath) as? FilterByCell ?? FilterByCell()
            filterCell.nonDiscountsButton.addTarget(self, action: #selector(nonDiscountsButtonTapped(sender:)), for: .primaryActionTriggered)
            filterCell.discountsButton.addTarget(self, action: #selector(discountsButtonTapped(sender:)), for: .primaryActionTriggered)
            
            let highlightedFont = UIFont.appBoldFontOfSize(size: 18)
            let normalFont = UIFont.appFontOfSize(size: 18)
            
            filterCell.nonDiscountsButton.titleLabel?.font = viewModel?.selectedTab == .NonDiscount ? highlightedFont : normalFont
            filterCell.discountsButton.titleLabel?.font = viewModel?.selectedTab == .NonDiscount ? normalFont : highlightedFont
            
            return filterCell
        case AdminSection.events.getSectionIndex():
            let eventCell = tableView.dequeueReusableCell(withIdentifier: "event-cell", for: indexPath) as? AdminEventCell ?? AdminEventCell()
            styleEventCell(eventCell: eventCell, indexPath: indexPath)
            return eventCell
        case AdminSection.action.getSectionIndex():
            let actionCell = tableView.dequeueReusableCell(withIdentifier: "action-cell", for: indexPath) as? ActionButtonsCell ?? ActionButtonsCell()
            actionCell.addEventButton.addTarget(self, action: #selector(addEventButtonTapped(sender:)), for: .primaryActionTriggered)
            actionCell.resetStateButton.addTarget(self, action: #selector(restoreStateButtonTapped(sender:)), for: .primaryActionTriggered)
            
            return actionCell
        default:
            return UITableViewCell()
        }
    }
    
    private func styleEventCell(eventCell: AdminEventCell, indexPath: IndexPath) {
        
        let pair = self.pairsToPresent[indexPath.row]
        let model = viewModel?.selectedTab == .Discount ? EventPresentationModel.initWithDiscountEntity(discount: pair.discount!) :
        EventPresentationModel.initWithEventEntity(event: pair.event)
        
        eventCell.editButton.tag = indexPath.row
        eventCell.deleteButton.tag = indexPath.row
        
        eventCell.editButton.addTarget(self, action: #selector(editEventButtonTapped(sender:)), for: .primaryActionTriggered)
        eventCell.deleteButton.addTarget(self, action: #selector(deleteEventButtonTapped(sender:)), for: .primaryActionTriggered)
        
        eventCell.eventView.eventImage.sd_setImage(with: URL(string: model.imageUrl))
        eventCell.eventView.monthLabel.text = FormatUtils.monthFromDate(date: model.date)
        eventCell.eventView.dayLabel.text = FormatUtils.dayOfTheMonthFromDate(date: model.date)
        eventCell.eventView.yearLabel.text = FormatUtils.yearFromDate(date: model.date)
        
        eventCell.eventView.nameView.text = model.name
        
        if let discount = model.discount {
            eventCell.eventView.discountView.isHidden = false
            eventCell.eventView.discountView.text = FormatUtils.formatDiscount(discount: discount)
            eventCell.eventView.priceView.text = FormatUtils.formatPrice(price:
                                                                            FormatUtils.caclulatePriceWithDiscount(price: model.price, discount:discount))
        } else {
            eventCell.eventView.discountView.isHidden = true
            eventCell.eventView.priceView.text = FormatUtils.formatPrice(price: model.price)
        }
        
        eventCell.eventView.timeLabel.text = FormatUtils.timeFromDate(date: model.date)
        eventCell.eventView.locationLabel.text = model.location
        eventCell.eventView.ticketsLeftLabel.text = FormatUtils.formatTicketsLeftMessage(quantity: model.quantity)
        
        
    }
    

    // MARK: handling events
    
    @objc private func discountsButtonTapped(sender: UIButton) {
        self.viewModel?.selectedTab = .Discount
    }
    
    @objc private func nonDiscountsButtonTapped(sender: UIButton) {
        self.viewModel?.selectedTab = .NonDiscount
    }
    
    @objc private func editEventButtonTapped(sender: UIButton) {
        let pair = self.pairsToPresent[sender.tag]
        self.showEditView(pair: pair)
    }
    
    @objc private func deleteEventButtonTapped(sender: UIButton) {
        showDeleteEventAlert(sender: sender)
    }
    
    @objc private func addEventButtonTapped(sender: UIButton) {
        self.showEditView(pair: nil)
    }
    
    @objc private func restoreStateButtonTapped(sender: UIButton) {
        showResetAppAlert(sender: sender)
    }
    
    
    private func showDeleteEventAlert(sender: UIButton) {
        
        let toDelete = self.viewModel?.selectedTab == .NonDiscount ? "Event" : "Discount"
        let alert = UIAlertController(title: "Delete \(toDelete) ", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            self.viewModel?.deleteEntity(pair: self.pairsToPresent[sender.tag])
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("EntityChanged"), object: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func showResetAppAlert(sender: UIButton) {
        
        let alert = UIAlertController(title: "Reset App?", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Reset", style: .destructive , handler:{ (UIAlertAction)in
            
            Task {
                await CoreDataHelper.clearDatabase()
                UserDefaults.standard.set(false, forKey: "hasDataStored")
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func showEditView(pair: EventDiscountPair?) {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "edit-vc") as! EditEventViewController
        let editEventViewModel = EditEventViewModel(context: PersistenceController.shared.container.newBackgroundContext(), eventDiscountPair: pair)
        editVC.viewModel = editEventViewModel
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
}
