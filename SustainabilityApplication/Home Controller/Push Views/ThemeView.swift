//
//  ThemeView.swift
//  SLIApp
//
//  Created by Chandler Long on 5/30/18.
//  Copyright © 2018 College of Charleston. All rights reserved.
//

import UIKit

class ThemeView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let themeOptions: [ThemeOption] = {
        return [ThemeOption(label: "Enviorment", imageName: "EnviormentLogo", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s.", color: Color.blue), ThemeOption(label: "Economic", imageName: "EconomicLogo", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s.", color: Color.green), ThemeOption(label: "Social", imageName: "SocialLogo", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s.", color: Color.yellow)]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.blue
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(ThemeCell.self, forCellWithReuseIdentifier: cellId)
        
        setUpCollectionView()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ThemeCell
        let themeOption = themeOptions[indexPath.row]
        
        cell.themeOption = themeOption
        return cell
    }
    
    func setUpCollectionView() {
        addSubview(collectionView)
        collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/*********THEME CELL**********/

class ThemeCell: UICollectionViewCell {
    
    
var themeOption: ThemeOption? {
        didSet {
            label.text = themeOption?.label
            label.textColor = themeOption?.color
            descriptionLabel.text = themeOption?.descriptionText
            seeMoreButton.backgroundColor = themeOption?.color
            if let imageName = themeOption?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var currentYear: Int!
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EnviormentLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let label: UILabel = {
        let text = UILabel()
        text.text = "Enviorment"
        //text.font =  UIFont(name: "Avenir Next", size: 20.0)
        text.font = UIFont.boldSystemFont(ofSize: 24.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = Color.blue
        
        return text
    }()
    
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.text = "Hi"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 8
        text.textColor = UIColor.lightGray
        
        return text
    }()
    
    let yearLabel: UILabel = {
        let text = UILabel()
        text.text = "2018-2019"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 8
        text.textColor = UIColor.lightGray
        
        return text
    }()
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.blue
        button.setTitle("SEE MORE", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        return button
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let date = Date()
        let calendar = Calendar.current
        currentYear = calendar.component(.year, from: date)
        addSubview(iconImageView)
        addSubview(label)
        addSubview(descriptionLabel)
        addSubview(yearLabel)
        addSubview(seeMoreButton)
        addSubview(seperatorView)
        setUpViews()
        
    }
    
    func setUpViews() {
        
        iconImageView.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 0)
        iconImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        label.setAnchor(top: topAnchor, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        descriptionLabel.setAnchor(top: label.bottomAnchor, left: iconImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 30)
        yearLabel.setAnchor(top: iconImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        seeMoreButton.setAnchor(top: descriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        seeMoreButton.centerX(centerX: centerXAnchor)
        seeMoreButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        seeMoreButton.widthAnchor.constraint(equalToConstant: frame.width / 1.2).isActive = true
        
        seperatorView.widthAnchor.constraint(equalToConstant: frame.width / 1.1).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        seperatorView.setAnchor(top: seeMoreButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        seperatorView.centerX(centerX: centerXAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ThemeOption: NSObject {
    let label: String
    let imageName: String
    let descriptionText: String
    let color: UIColor
    
    init(label: String, imageName: String, description: String, color: UIColor) {
        self.imageName = imageName
        self.label = label
        self.descriptionText = description
        self.color = color
    }
}

