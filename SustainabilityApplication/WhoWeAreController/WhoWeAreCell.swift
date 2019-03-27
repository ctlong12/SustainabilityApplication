//
//  WhoWeAreCell.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/18/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Firebase

class WhoWeAreCell: UICollectionViewCell {
    
    var whoWeAreOption: WhoWeAreOption? {
        didSet {
            nameLabel.text = whoWeAreOption?.name
            descriptionLabel.text = whoWeAreOption?.descriptionText
            nameLabel.textColor = whoWeAreOption?.textColor
            positionLabel.text = whoWeAreOption?.position
            positionLabel.textColor = whoWeAreOption?.textColor
            if let imageName = whoWeAreOption?.profileImage {
                self.profileImage.image = UIImage(named: "\(imageName)")
            }
        }
    }
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blankProfile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let text = UILabel()
        text.text = "Chandler:"
        text.font =  UIFont(name: "Avenir Next", size: 24.0)
        text.font = UIFont.boldSystemFont(ofSize: 22.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Color.blue
        
        return text
    }()
    
    let positionLabel: UILabel = {
        let text = UILabel()
        text.text = "Presedent"
        text.font =  UIFont(name: "Avenir Next", size: 14.0)
        text.numberOfLines = 2
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Color.blue
        
        return text
    }()
    
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s."
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 4
        text.textColor = UIColor.lightGray
        
        return text
    }()
    
    lazy var readFullBio: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "FullBioButton"), for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        //button.addTarget(whoWeAreController, action: #selector(whoWeAreController.handleFullBio), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(positionLabel)
        addSubview(descriptionLabel)
        addSubview(readFullBio)
        
        setUpViews()
        
    }
    
    func setUpViews() {
        profileImage.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 0)
        profileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        nameLabel.setAnchor(top: topAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        positionLabel.setAnchor(top: nameLabel.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 8)
        descriptionLabel.setAnchor(top: positionLabel.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        readFullBio.setAnchor(top: nil, left: profileImage.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 00, paddingLeft: 13, paddingBottom: 0, paddingRight: 0)
        readFullBio.heightAnchor.constraint(equalToConstant: 25).isActive = true
        readFullBio.widthAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WhoWeAreOption: NSObject {
    let name: String
    let profileImage: String
    let descriptionText: String
    let position: String
    let textColor: UIColor
    
    init(name: String, profileImage: String, description: String, position: String, color: UIColor) {
        self.name = name
        self.profileImage = profileImage
        self.descriptionText = description
        self.position = position
        self.textColor = color
        
    }
}

class BioCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setUpViews()
        
    }
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let bioTextView: UITextView = {
        let text = UITextView()
        text.text = "Todd LeVasseur is a visiting professor in religious studies. He also teaches within the Environmental and Sustainability Studies Program. His focus as a scholar involves the interface of religious beliefs/experiences/institutional identities/practices and cultural narratives and how these shape and are shaped by the natural world."
        text.font =  UIFont(name: "Avenir Next", size: 18.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .lightGray
        text.backgroundColor = .clear
        text.isScrollEnabled = false
        
        return text
    }()
    
    func setUpViews() {
        
        addSubview(seperatorView)
        addSubview(bioTextView)
        
        seperatorView.widthAnchor.constraint(equalToConstant: frame.width / 1.1).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        seperatorView.setAnchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        seperatorView.centerX(centerX: centerXAnchor)
        bioTextView.setAnchor(top: seperatorView.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
