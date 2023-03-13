//
//  SettingLauncher.swift
//  LW Customer
//
//  Created by MOLIDA LOEUNG on 11/12/20.
//  Copyright © 2020 IG. All rights reserved.
//

import UIKit
import AudioToolbox

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let height: CGFloat = 50
    private let cellId = "cellId"
    private var message = ""
    private var color: UIColor!
    
    private lazy var settingsMenuCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 10
        cv.layer.masksToBounds = true
        return cv
    }()
    
    @objc func showSettings(color: UIColor, message: String) {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                let tabBarHeight: CGFloat = 49 + window.safeAreaInsets.bottom + 10 // Tab bar height + SafeAreaInset.bottom + Extra 10
                let y = window.frame.height - self.height - tabBarHeight
                self.settingsMenuCollectionView.frame = CGRect(x: 10, y: window.frame.height, width: window.frame.width - 20, height: self.height)
                window.addSubview(self.settingsMenuCollectionView)
                self.settingsMenuCollectionView.backgroundColor = color
                self.message = message
                self.color = color
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,options: .curveEaseIn, animations: {
                    AudioServicesPlayAlertSound(1519)
                    self.settingsMenuCollectionView.frame.origin.y = y
                })
            }
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.settingsMenuCollectionView.frame.origin.y = window.frame.height
                }) { _ in
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        cell.configureView(backgroundColor: color, hideIcon: false, title: message, textColor: .white)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: height)
    }
    
}
