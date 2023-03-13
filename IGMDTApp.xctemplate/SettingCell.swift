//
//  SettingCell.swift
//  LW Customer
//
//  Created by MOLIDA LOEUNG on 11/12/20.
//  Copyright © 2020 IG. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    private lazy var icon: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "icons8-wi-fi_off"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var settingTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 18)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        addSubview(settingTitle)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            settingTitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            settingTitle.centerYAnchor.constraint(equalTo: icon.centerYAnchor)
        ])
    }
    
    func configureView(backgroundColor: UIColor, hideIcon: Bool = true, title: String, textColor: UIColor = .white) {
        self.backgroundColor = backgroundColor
        if hideIcon {
            icon.widthAnchor.constraint(equalToConstant: 0).isActive = true
        }
        settingTitle.text = title
        settingTitle.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
