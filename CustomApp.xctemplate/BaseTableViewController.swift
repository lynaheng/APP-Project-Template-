import Combine
import MJRefresh
import UIKit

class BaseTableViewController<VM: TableViewModel>: UITableViewController {
    
    var viewModel: VM!
    final var datasource: TableViewDataSource!
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
        initTableView()
    }
    
    func initTableView() {
        fatalError("\(NSStringFromClass(type(of: self))) - initTableView() has not been implemented")
    }
    
    func setupPagination() {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.page += 1
        })
    }
    
    /// identifiers must be in section respectively
    final func prepareDataSource(identifiers: String...) {
        datasource = TableViewDataSource(identifiers: identifiers, viewModel: viewModel)
        tableView.dataSource = datasource
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
