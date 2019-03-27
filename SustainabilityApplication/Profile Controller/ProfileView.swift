//
//  ProfileView.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/15/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Firebase

class ProfileCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.backgroundColor
        
        setUpViews()
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary  = snapshot.value as? [String: AnyObject] {
                if let rank = dictionary["rank"] as? String {
                    self.rankLabel.text = "Rank: \(rank)"
                }
                
                if let major = dictionary["major"] as? String {
                    self.majorLabel.text = "Major: \(major)"
                }
            }
            
        }, withCancel: nil)
    }
    
    let eventDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let clipboardIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let sideBarView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let profileIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileInfo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let majorLabel: UILabel = {
        let text = UILabel()
        text.text = "Major: Computer Science"
        text.font =  UIFont(name: "Avenir Next", size: 14.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.white
        
        return text
    }()
    
    let rankLabel: UILabel = {
        let text = UILabel()
        text.text = "Rank: Junior"
        text.font =  UIFont(name: "Avenir Next", size: 14.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.white
        
        return text
    }()
    
    let descriptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        return view
    }()
    
    let quoteLabel: UILabel = {
        let text = UILabel()
        text.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters."
        text.font =  UIFont(name: "Avenir Next", size: 14.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 4
        text.textAlignment = .center
        text.textColor = UIColor.black
        
        return text
    }()
    
    lazy var changeQuoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.blue
        
        button.setTitle("Change Quote", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font =  UIFont(name: "AvenirNext", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        
        //button.addTarget(self, action: #selector(handleGoToRegister), for: .touchUpInside)
        
        return button
    }()
    
    let eventDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let eventLeftBar: UIView = {
        let view = UIView()
        view.backgroundColor = Color.yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let eventRightBar: UIView = {
        let view = UIView()
        view.backgroundColor = Color.green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let congratsLabel: UILabel = {
        let text = UILabel()
        text.text = "Congratulations!"
        text.font =  UIFont(name: "Avenir Next", size: 24.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 1
        text.textColor = UIColor.white
        
        return text
    }()
    
    let attendedEventsLabel: UILabel = {
        let text = UILabel()
        text.text = "You have attended a total of 8 events!"
        text.font =  UIFont(name: "Avenir Next", size: 18.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textAlignment = .center
        text.textColor = UIColor.white
        
        return text
    }()
    
    let justiceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "socialJustice")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setUpViews() {
        addSubview(eventDetailsContainerView)
        eventDetailsContainerView.addSubview(clipboardIconContainerView)
        eventDetailsContainerView.addSubview(sideBarView)
        clipboardIconContainerView.addSubview(profileIconImage)
        
        
        eventDetailsContainerView.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventDetailsContainerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        clipboardIconContainerView.setAnchor(top: eventDetailsContainerView.topAnchor, left: eventDetailsContainerView.leftAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        clipboardIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true
        
        sideBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        sideBarView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        sideBarView.setAnchor(top: nil, left: nil, bottom: nil, right: eventDetailsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        sideBarView.centerY(centerY: eventDetailsContainerView.centerYAnchor)
        
        profileIconImage.setAnchor(top: clipboardIconContainerView.topAnchor, left: clipboardIconContainerView.leftAnchor, bottom: clipboardIconContainerView.bottomAnchor, right: clipboardIconContainerView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
        
        setUpLabels()
        
    }
    
    func setUpLabels() {
        eventDetailsContainerView.addSubview(majorLabel)
        eventDetailsContainerView.addSubview(rankLabel)
        
        majorLabel.setAnchor(top: eventDetailsContainerView.topAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: sideBarView.leftAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 10)
        
        rankLabel.setAnchor(top: majorLabel.bottomAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: sideBarView.leftAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 10)
        
        setUpButtonDescription()
        
    }
    
    func setUpButtonDescription() {
        addSubview(descriptionContainerView)
        descriptionContainerView.addSubview(quoteLabel)
        addSubview(changeQuoteButton)
        
        descriptionContainerView.setAnchor(top: eventDetailsContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        descriptionContainerView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        quoteLabel.setAnchor(top: descriptionContainerView.topAnchor, left: descriptionContainerView.leftAnchor, bottom: descriptionContainerView.bottomAnchor, right: descriptionContainerView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
        
        changeQuoteButton.setAnchor(top: quoteLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 35, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        changeQuoteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setUpEventsDescription()
    }
    
    func setUpEventsDescription() {
        addSubview(eventDescriptionView)
        eventDescriptionView.addSubview(eventLeftBar)
        eventDescriptionView.addSubview(eventRightBar)
        eventDescriptionView.addSubview(congratsLabel)
        eventDescriptionView.addSubview(attendedEventsLabel)
        
        addSubview(justiceImage)
        
        eventDescriptionView.setAnchor(top: changeQuoteButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventDescriptionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        eventLeftBar.setAnchor(top: eventDescriptionView.topAnchor, left: eventDescriptionView.leftAnchor, bottom: eventDescriptionView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventLeftBar.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        eventRightBar.setAnchor(top: eventDescriptionView.topAnchor, left: nil, bottom: eventDescriptionView.bottomAnchor, right: eventDescriptionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventRightBar.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        congratsLabel.setAnchor(top: eventDescriptionView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        congratsLabel.centerX(centerX: centerXAnchor)
        
        attendedEventsLabel.setAnchor(top: congratsLabel.bottomAnchor, left: eventLeftBar.rightAnchor, bottom: eventDescriptionView.bottomAnchor, right: eventRightBar.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 5, paddingRight: 8)
        attendedEventsLabel.centerX(centerX: centerXAnchor)
        
        justiceImage.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        justiceImage.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

