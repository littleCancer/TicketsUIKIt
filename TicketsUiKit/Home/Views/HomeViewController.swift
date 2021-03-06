//
//  HomeViewController.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , DiscountDetailsPresenter {

    
    let discountsDataSourceAndDelegate = DiscountsCollectionDataSourceAndDelegate()
    let expiredEventsSourceAndDelegate = ExpiredEventsCollectionDataSourceAndDelegate()
    var progressView: UIActivityIndicatorView?
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel: HomeViewModel = HomeViewModel(eventsFetcher: FetchEventsService(requestManager: RequestManager()), eventsStore: EventsStoreService(context: PersistenceController.shared.container.viewContext))
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var dataNotLoaded:Bool {
        return viewModel.upcoming.isEmpty && viewModel.discounts.isEmpty
            && viewModel.expired.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleSubviews()
        funcSetUpObserving()
        
        registerCells()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: Notification.Name("EntityChanged"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            if (!UserDefaults.standard.bool(forKey: "hasDataStored")) {
                await viewModel.fetchEvents()
                
            }
            if (self.dataNotLoaded) {
                viewModel.loadModel()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func styleSubviews() {
        self.view.backgroundColor = UIColor.appGray
        let titleLabel = UILabel()
        titleLabel.text = "Concert Tickets"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appBoldFontOfSize(size: 22)
        self.navigationItem.titleView = titleLabel
        
        discountsDataSourceAndDelegate.discountPresenter = self
        expiredEventsSourceAndDelegate.eventPresenter = self
        
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 3))
        separator.backgroundColor = UIColor.appDividerGray
        self.view.insertSubview(separator, aboveSubview: tableView)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 300).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        self.tableView.separatorStyle = .none
        
        progressView = UIActivityIndicatorView()
        self.view.insertSubview(progressView!, aboveSubview: tableView)
        progressView?.translatesAutoresizingMaskIntoConstraints = false
        progressView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressView?.style = .large
        progressView?.hidesWhenStopped = true
        progressView?.stopAnimating()
        
    }
    
    private func funcSetUpObserving() {
        viewModel.$upcoming.sink { [weak self] upcoming in
            self?.tableView.reloadData()
        }.store(in: &cancellableSet)
        
        viewModel.$discounts.sink { [weak self] discounts in
            self?.discountsDataSourceAndDelegate.discounts = discounts
            self?.tableView.reloadData()
        }.store(in: &cancellableSet)
        
        viewModel.$expired.sink { [weak self] expired in
            self?.expiredEventsSourceAndDelegate.expiredEvents = expired
            self?.tableView.reloadData()
        }.store(in: &cancellableSet)
        
        viewModel.$isLoading.sink(receiveValue: { [weak self] loading in
            if loading {
                self?.progressView?.startAnimating()
            } else {
                self?.progressView?.stopAnimating()
            }
                
        }).store(in: &cancellableSet)
    }
    
    private func registerCells() {
        tableView.register(DiscountListTableCell.self, forCellReuseIdentifier: "DiscountCell")
        tableView.register(UpcomingEventViewTableViewCell.self, forCellReuseIdentifier: "UpcomingCell")
        tableView.register(ExpiredListTableCellTableViewCell.self, forCellReuseIdentifier: "ExpiredCell")
        tableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "ActionCell")
    }
    
    @objc func reloadView() {
        viewModel.loadModel()
        self.tableView.reloadData()
    }
    
    // MARK: UITableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.isLoading {
            return 0
        }
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.forYou.getSectionIndex():
            return 1
        case Section.upcoming.getSectionIndex():
            return viewModel.upcoming.count
        case Section.expired.getSectionIndex():
            return 1
        case Section.action.getSectionIndex():
            return 1
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != Section.action.getSectionIndex() else {
            return nil
        }
        let titleLabel = InsetLabel()
        titleLabel.text = Section.allCases[section].getSectionTitle()
        titleLabel.font = UIFont.appBoldFontOfSize(size: 28)
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section != Section.action.getSectionIndex() else {
            return 10
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.forYou.getSectionIndex():
            return 400
        case Section.action.getSectionIndex():
            return 60
        default:
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case Section.forYou.getSectionIndex():
                let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as? DiscountListTableCell ?? DiscountListTableCell()
                cell.selectionStyle = .none
                cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self.discountsDataSourceAndDelegate, forRow: indexPath.row)
                return cell
            case Section.upcoming.getSectionIndex():
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingCell", for: indexPath) as? UpcomingEventViewTableViewCell ?? UpcomingEventViewTableViewCell()
                cell.selectionStyle = .none
                cell.event = viewModel.upcoming[indexPath.row]
                return cell
            case Section.expired.getSectionIndex():
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExpiredCell", for: indexPath) as?
                ExpiredListTableCellTableViewCell ?? ExpiredListTableCellTableViewCell()
                cell.selectionStyle = .none
                cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self.expiredEventsSourceAndDelegate, forRow: indexPath.row)
                return cell
            case Section.action.getSectionIndex():
                let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as? ActionCell ?? ActionCell()
                cell.adminButton.addTarget(self, action: #selector(presentAdminViewController), for: .primaryActionTriggered)
                return cell
            
        
        default:
            return UITableViewCell()
        }
        
    }
    
    // MARK: UITableViewController delegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.upcoming[indexPath.row]
        presentDetailViewController(for: event)
    }
    
    private func presentDetailViewController(for entity: EventEntity) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "detail-vs") as! DetailViewController
        let viewModel = DetailsViewModel(eventEntity: entity)
        detailsVC.viewModel = viewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    private func presentDetailViewController(for discount: DiscountEntity) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "detail-vs") as! DetailViewController
        let viewModel = DetailsViewModel(discountEntity: discount)
        detailsVC.viewModel = viewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func showViewControllerFor(discount: DiscountEntity) {
        self.presentDetailViewController(for: discount)
    }
    
    @objc private func presentAdminViewController() {
        let adminVC = self.storyboard?.instantiateViewController(withIdentifier: "admin-vc")
        as! AdminViewController
        self.navigationController?.pushViewController(adminVC, animated: true)
    }
    
}

protocol DiscountDetailsPresenter: AnyObject {
    func showViewControllerFor(discount: DiscountEntity)
}

enum Section: CaseIterable {
    case forYou
    case upcoming
    case expired
    case action
    
    func getSectionTitle() -> String {
        switch self {
        case .forYou:
            return "For you"
        case .upcoming:
            return "Upcoming"
        case .expired:
            return "Expired"
        case .action:
            return ""
        }
    }
    
    func getSectionIndex() -> Int {
        switch self {
        case .forYou:
            return 0
        case .upcoming:
            return 1
        case .expired:
            return 2
        case .action:
            return 3
        }
    }
}

class DiscountsCollectionDataSourceAndDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var discountPresenter: DiscountDetailsPresenter?
    var discounts: [DiscountEntity] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let disount = discounts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DiscountCell ?? DiscountCell()
        cell.eventImage.sd_setImage(with: URL(string: ApiUtils.getImageUrl(imagePath: disount.photo ?? "")))
        cell.name.text = disount.name
        cell.date.text = FormatUtils.formatDate(date: disount.date ?? Date.now)
        
        let price = FormatUtils.caclulatePriceWithDiscount(price: disount.price, discount: disount.discount)
        cell.promoText.text = FormatUtils.formatAvailabilityMessage(amount: price, quantity: disount.quantity)
        cell.roundText.text = FormatUtils.formatDiscount(discount: disount.discount)
        cell.location.text = disount.place
        
        return cell
    }
    
    // MARK UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let discount = self.discounts[indexPath.row]
        self.discountPresenter?.showViewControllerFor(discount: discount)
    }
    
}

class ExpiredEventsCollectionDataSourceAndDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var eventPresenter: DiscountDetailsPresenter?
    var expiredEvents: [DiscountEntity] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expiredEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let expired = expiredEvents[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ExpiredEventViewCell ?? ExpiredEventViewCell()
        cell.eventImage.sd_setImage(with: URL(string: ApiUtils.getImageUrl(imagePath: expired.photo ?? "")))
        cell.discounntView.text = FormatUtils.formatDiscount(discount: expired.discount)
        cell.nameView.text = expired.name ?? ""
        cell.locationLabel.text = expired.place
        
        return cell
    }
    
    // MARK UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.expiredEvents[indexPath.row]
        self.eventPresenter?.showViewControllerFor(discount: event)
    }
    
}
