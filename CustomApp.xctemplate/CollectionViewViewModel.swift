//
//  CollectionViewViewModel.swift
//  iOS-MVVM-Core
//
//  Created by MOLIDA LOEUNG on 6/29/21.
//

import Combine
import UIKit

protocol CollectionViewViewModel: BaseViewModel {
    func numberOfItems(at section: Int) -> Int
    func cellForItem(at indexPath: IndexPath, for cell: UICollectionViewCell) -> UICollectionViewCell
}

extension CollectionViewViewModel {
    var numberOfSection: Int {
        return 1
    }
}

