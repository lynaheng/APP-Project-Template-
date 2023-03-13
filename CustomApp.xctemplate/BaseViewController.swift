//
//  BaseViewController.swift
//  iOS-MVVM-Core
//
//  Created by MOLIDA LOEUNG on 4/9/21.
//

import Combine
import UIKit

class BaseViewController<UV: BaseUIView, VM: BaseViewModel>: UIViewController {
    
    var subView: UV!
    var viewModel: VM!
    private var subscription: Cancellable?
    
    var getViewModel: VM {
        fatalError("\(NSStringFromClass(type(of: self))) - getViewModel has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        subView = UV()
        self.view = subView
        viewModel = getViewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupBindings()
    }
    
    final func handleLoading() {
        subscription = viewModel.viewModelState
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
    
    func initView() {
        fatalError("\(NSStringFromClass(type(of: self))) - initView() has not been implemented")
    }
    
    func setupBindings() { }
    
    deinit {
        print("OS reclaiming memory - \(NSStringFromClass(type(of: self))) - NO Retain Cycle")
    }
    
}
