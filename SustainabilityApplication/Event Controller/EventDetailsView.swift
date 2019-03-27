//
//  EventDetailsView.swift
//  SLIApp
//
//  Created by Chandler Long on 6/26/18.
//  Copyright © 2018 College of Charleston. All rights reserved.
//

import UIKit
import MapKit

class EventDetailsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.contentInset = UIEdgeInsetsMake(280, 0, 0, 0)
        return cv
    }()
    
    let profileBannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        imageView.image = UIImage.init(named: "test")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        backgroundColor = Color.backgroundColor
        
        collectionView.register(EventDetailsPageCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(profileBannerView)
        setUpCollectionView()
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 150 - (scrollView.contentOffset.y + 150)
        let height = min(max(y, 60), 600)
        profileBannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventDetailsPageCell
        return cell
    }
    
    func setUpCollectionView() {
        addSubview(collectionView)
        collectionView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class EventDetailsPageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpEventDetailsContainer()
        backgroundColor = Color.backgroundColor
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
    
    let calendarIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let clipboardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clipboard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let overtimeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "overtime")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let eventNameLabel: UILabel = {
        let text = UILabel()
        text.text = "Cistern Yard Concert and Dance"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        text.textColor = UIColor.white
        
        return text
    }()
    
    let locationLabel: UILabel = {
        let text = UILabel()
        text.text = "Cistern Yard"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.white
        
        return text
    }()
    
    let dateLabel: UILabel = {
        let text = UILabel()
        text.text = "Tuesday April 11th, 2018"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        text.textAlignment = .right
        text.textColor = UIColor.white
        
        return text
    }()
    
    let timeLabel: UILabel = {
        let text = UILabel()
        text.text = "8:00pm"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 1
        text.textAlignment = .right
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
    
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.text = "Come join us for a night of dancing, music, prizes and food. First come first serve basis"
        text.font =  UIFont(name: "Avenir Next", size: 14.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        text.textAlignment = .center
        text.textColor = UIColor.black
        
        return text
    }()
    
    lazy var attendingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.blue
        
        button.setTitle("Attending!", for: .normal)
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
    
    let addressContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let mapIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let mapImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mapicon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let text = UILabel()
        text.text = "66 George Street Charleston SC, 29403"
        text.font =  UIFont(name: "Avenir Next", size: 14.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        text.textAlignment = .left
        text.textColor = UIColor.white
        
        return text
    }()
    
    func setUpEventDetailsContainer() {
        addSubview(eventDetailsContainerView)
        eventDetailsContainerView.addSubview(clipboardIconContainerView)
        eventDetailsContainerView.addSubview(separatorView)
        eventDetailsContainerView.addSubview(calendarIconContainerView)
        clipboardIconContainerView.addSubview(clipboardImage)
        calendarIconContainerView.addSubview(overtimeImage)
        
        eventDetailsContainerView.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventDetailsContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true

        clipboardIconContainerView.setAnchor(top: eventDetailsContainerView.topAnchor, left: eventDetailsContainerView.leftAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        clipboardIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true

        separatorView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.centerX(centerX: eventDetailsContainerView.centerXAnchor)
        separatorView.centerY(centerY: eventDetailsContainerView.centerYAnchor)

        calendarIconContainerView.setAnchor(top: eventDetailsContainerView.topAnchor, left: nil, bottom: eventDetailsContainerView.bottomAnchor, right: eventDetailsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        calendarIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true

        clipboardImage.centerX(centerX: clipboardIconContainerView.centerXAnchor)
        clipboardImage.centerY(centerY: clipboardIconContainerView.centerYAnchor)

        overtimeImage.centerX(centerX: calendarIconContainerView.centerXAnchor)
        overtimeImage.centerY(centerY: calendarIconContainerView.centerYAnchor)
        
        setUpLabels()
        
    }
    
    func setUpLabels() {
        eventDetailsContainerView.addSubview(eventNameLabel)
        eventDetailsContainerView.addSubview(locationLabel)
        eventDetailsContainerView.addSubview(dateLabel)
        eventDetailsContainerView.addSubview(timeLabel)
        
        eventNameLabel.setAnchor(top: eventDetailsContainerView.topAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: separatorView.leftAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 2)
        
        locationLabel.setAnchor(top: nil, left: clipboardIconContainerView.rightAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: separatorView.leftAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 2)
        
        dateLabel.setAnchor(top: eventDetailsContainerView.topAnchor, left: separatorView.rightAnchor, bottom: nil, right: calendarIconContainerView.leftAnchor, paddingTop: 5, paddingLeft: 2, paddingBottom: 0, paddingRight: 5)
        
        timeLabel.setAnchor(top: nil, left: separatorView.rightAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: calendarIconContainerView.leftAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 5, paddingRight: 5)
        
        setUpButtonDescription()
    }
    
    func setUpButtonDescription() {
        addSubview(descriptionContainerView)
        descriptionContainerView.addSubview(descriptionLabel)
        addSubview(attendingButton)
        
        descriptionContainerView.setAnchor(top: eventDetailsContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        descriptionContainerView.heightAnchor.constraint(equalToConstant: 165).isActive = true
        
        descriptionLabel.setAnchor(top: descriptionContainerView.topAnchor, left: descriptionContainerView.leftAnchor, bottom: descriptionContainerView.bottomAnchor, right: descriptionContainerView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
        
        attendingButton.setAnchor(top: descriptionContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        attendingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        setUpMapView()
    }
    
    let mapView = MKMapView()
    
    func setUpMapView() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.setAnchor(top: attendingButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        setUpAdressContainer()
    }
    
    func setUpAdressContainer() {
        addSubview(addressContainerView)
        addressContainerView.addSubview(mapIconContainerView)
        mapIconContainerView.addSubview(mapImage)
        addressContainerView.addSubview(addressLabel)
        
        addressContainerView.setAnchor(top: mapView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        mapIconContainerView.setAnchor(top: addressContainerView.topAnchor, left: addressContainerView.leftAnchor, bottom: addressContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mapIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5.2).isActive = true
        mapImage.centerX(centerX: mapIconContainerView.centerXAnchor)
        mapImage.centerY(centerY: mapIconContainerView.centerYAnchor)
        
        addressLabel.setAnchor(top: nil, left: mapIconContainerView.rightAnchor, bottom: nil, right: addressContainerView.rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 10)
        addressLabel.centerY(centerY: addressContainerView.centerYAnchor)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
