//
//  MenuCell.swift
//  SLIApp
//
//  Created by Chandler Long on 5/15/18.
//  Copyright © 2018 College of Charleston. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
            menuLabel.textColor = isHighlighted ? UIColor.white : UIColor.lightGray
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.lightGray
        }
    }
    
    var menuOption: MenuOption? {
        didSet {
            menuLabel.text = menuOption?.name
            if let imageName = menuOption?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let menuLabel: UILabel = {
        let text = UILabel()
        text.text = "Home"
        text.font =  UIFont(name: "Avenir Next", size: 18.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.lightGray
        
        return text
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "homeIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(menuLabel)
        addSubview(iconImageView)
        setUpViews()
    }
    
    func setUpViews() {
        
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        menuLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 5).isActive = true
        menuLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        menuLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
