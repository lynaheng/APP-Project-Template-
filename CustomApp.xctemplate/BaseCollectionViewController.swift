//
//  BaseCollectionViewController.swift
//  iOS-MVVM-Core
//
//  Created by MOLIDA LOEUNG on 6/29/21.
//

import Combine
import MJRefresh
import UIKit

class BaseCollectionViewController<VM: CollectionViewViewModel>: UICollectionViewController {
    
    var viewModel: VM!
    final var datasource: CollectionViewDataSource!
    @Published var page = 0
    private var loadingSubscription: Cancellable?
    
    var getViewModel: VM {
        fatalError("\(NSStringFromClass(type(of: self))) - getViewModel has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = getViewModel
        initCollectionView()
    }
    
    func initCollectionView() {
        fatalError("\(NSStringFromClass(type(of: self))) - initCollectionView() has not been implemented")
    }
    
    func setupPagination() {
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.page += 1
        })
    }
    
    /// identifiers must be in section respectively
    final func prepareDataSource(identifiers: String...) {
//        datasource = ObjectDataSource(identifiers: identifiers, viewModel: viewModel)
//        tableView.dataSource = datasource
    }
    
    final func handleLoading() {
        loadingSubscription = viewModel.viewModelState
            .receive(on: DispatchQueue.main)
            .sink { state in
            switch state {
                case .loading:
                    Indicator.shared.show()
                case .finished:
                    Indicator.shared.hide()
                case .error(let error):
                    Indicator.shared.hide()
                    UIApplication.shared.showMessage(title: "Error", message: error)
            }
        }
    }
    
    func setupNavigation() { }
    
    deinit {
        print("OS reclaiming memory - \(NSStringFromClass(type(of: self))) - NO Retain Cycle")
    }
    
}

