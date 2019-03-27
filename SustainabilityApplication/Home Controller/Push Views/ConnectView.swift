//
//  ConnectView.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/19/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit

class ConnectView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    //var fellow: WhoWeAreOption!
    
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
        imageView.image = UIImage.init(named: "fellows")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blankProfile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        backgroundColor = UIColor.white
        
        collectionView.register(SocialCell.self, forCellWithReuseIdentifier: cellId)
        
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
        
        return CGSize(width: collectionView.frame.width, height: 1050)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SocialCell
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

class SocialCell: UICollectionViewCell {
    
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
        text.text = "Chandler Long"
        text.font =  UIFont(name: "Avenir Next", size: 18.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .lightGray
        text.backgroundColor = .clear
        text.isScrollEnabled = false
        
        return text
    }()
    
    let contact1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "contact1")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let socialLabel: UILabel = {
        let text = UILabel()
        text.text = "Social Links"
        text.font =  UIFont(name: "Arial", size: 40.0)
        //text.font = UIFont.boldSystemFont(ofSize: 30.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 1
        text.textColor = Color.red
        
        return text
    }()
    
    let seperatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let facebookIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "facebook")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let instagramIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "instagram")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let twitterIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "twitter")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let youtubeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "youtube")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let snapchatIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snapchat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let googleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "google")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setUpViews() {
        
        addSubview(seperatorView)
        addSubview(contact1)
        addSubview(seperatorView2)
        addSubview(socialLabel)
        addSubview(facebookIcon)
        addSubview(instagramIcon)
        addSubview(twitterIcon)
        addSubview(youtubeIcon)
        addSubview(snapchatIcon)
        addSubview(googleIcon)
        
        seperatorView.widthAnchor.constraint(equalToConstant: frame.width / 1.1).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        seperatorView.setAnchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        seperatorView.centerX(centerX: centerXAnchor)
        contact1.setAnchor(top: seperatorView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        contact1.heightAnchor.constraint(equalToConstant: 475).isActive = true
        contact1.widthAnchor.constraint(equalToConstant: frame.width).isActive = true

        seperatorView2.widthAnchor.constraint(equalToConstant: frame.width / 1.1).isActive = true
        seperatorView2.heightAnchor.constraint(equalToConstant: 2).isActive = true
        seperatorView2.setAnchor(top: contact1.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        seperatorView2.centerX(centerX: centerXAnchor)
        socialLabel.setAnchor(top: seperatorView2.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        facebookIcon.setAnchor(top: socialLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        facebookIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        facebookIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        instagramIcon.setAnchor(top: socialLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 40)
        instagramIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        instagramIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        twitterIcon.setAnchor(top: facebookIcon.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        twitterIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        twitterIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        youtubeIcon.setAnchor(top: instagramIcon.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 40)
        youtubeIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        youtubeIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        snapchatIcon.setAnchor(top: twitterIcon.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        snapchatIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        snapchatIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        googleIcon.setAnchor(top: youtubeIcon.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 40)
        googleIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        googleIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
