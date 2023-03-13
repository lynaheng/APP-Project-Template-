//
//  TableViewModel.swift
//  iOS-MVVM-Core
//
//  Created by MOLIDA LOEUNG on 5/17/21.
//

import Combine
import UIKit

protocol TableViewModel: BaseViewModel {
    func numberOfRows(at section: Int) -> Int
    func cellForRow(at indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell
}

extension TableViewModel {
    var numberOfSection: Int {
        return 1
    }
}
