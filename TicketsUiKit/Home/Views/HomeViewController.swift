//
//  HomeViewController.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                          UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel: HomeViewModel = HomeViewModel(eventsFetcher: FetchEventsService(requestManager: RequestManager()), eventsStore: EventsStoreService(context: PersistenceController.shared.container.newBackgroundContext()))
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$isLoading.sink(receiveValue: { [weak self] loading in
            print("is loading ----- \(loading)")
        }).store(in: &cancellableSet)
        
        viewModel.$upcoming.sink { [weak self] _ in
//            self?.tableView.reloadData()
        }.store(in: &cancellableSet)
        
        viewModel.$discounts.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellableSet)
        
        viewModel.$expired.sink { [weak self] _ in
//            self?.tableView.reloadData()
        }.store(in: &cancellableSet)
        
        Task {
            if (!UserDefaults.standard.bool(forKey: "hasDataStored")) {
                await viewModel.fetchEvents()
            }
            viewModel.loadModel()
        }
        tableView.register(DiscountListTableCell.self, forCellReuseIdentifier: "DiscountCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.forYou.getSectionIndex():
            return 1
        case Section.upcoming.getSectionIndex():
            return viewModel.upcoming.count
        case Section.expired.getSectionIndex():
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].getSectionTitle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.forYou.getSectionIndex():
            return 400
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case Section.forYou.getSectionIndex():
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as? DiscountListTableCell ?? DiscountListTableCell()
            cell.selectionStyle = .none
            if cell.discounts.isEmpty {
                cell.discounts = viewModel.discounts
            }
            return cell
            case Section.upcoming.getSectionIndex():
                return UITableViewCell()
            case Section.expired.getSectionIndex():
                return UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {

        switch indexPath.section {
        case Section.forYou.getSectionIndex():
            guard let tableViewCell = cell as? DiscountListTableCell else { return }

            tableViewCell.discountCollectionView?.frame = tableViewCell.bounds
//            tableViewCell.discountCollectionView?.delegate = self
//            tableViewCell.discountCollectionView?.dataSource = self
        default:
            return
        }
        
    }
    
}


enum Section: CaseIterable {
    case forYou
    case upcoming
    case expired
    
    func getSectionTitle() -> String {
        switch self {
        case .forYou:
            return "For you"
        case .upcoming:
            return "Upcoming"
        case .expired:
            return "Expired"
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
        }
    }
}
