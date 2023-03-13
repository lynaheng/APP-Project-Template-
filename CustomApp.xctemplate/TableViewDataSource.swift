//
//  ObjectDataSource.swift
//  iOS-MVVM-Core
//
//  Created by MOLIDA LOEUNG on 4/9/21.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    private let identifiers: [String]
    private let viewModel: TableViewModel
    
    init(identifiers: [String], viewModel: TableViewModel) {
        self.identifiers = identifiers
        self.viewModel = viewModel
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        identifiers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        return viewModel.cellForRow(at: indexPath, for: cell)
    }
    
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let identifiers: [String]
    private let viewModel: CollectionViewViewModel
    
    init(identifiers: [String], viewModel: CollectionViewViewModel) {
        self.identifiers = identifiers
        self.viewModel = viewModel
    }
    
    // MARK: - Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        identifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers[indexPath.section], for: indexPath)
        return viewModel.cellForItem(at: indexPath, for: cell)
    }
}
