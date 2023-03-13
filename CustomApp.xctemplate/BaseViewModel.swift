//
//  BaseViewModel.swift
//  iOS-MVVM-Core
//
//  Created by MOLIDA LOEUNG on 5/18/21.
//

import Foundation

enum ViewModelState {
    case loading
    case finished
    case error(String)
}

protocol BaseViewModel {
    var viewModelState: Published<ViewModelState>.Publisher { get }
}
