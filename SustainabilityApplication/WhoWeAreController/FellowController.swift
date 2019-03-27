//
//  FellowController.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/22/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit

class FellowController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var fellow: WhoWeAreOption!
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        
        cv.contentInset = UIEdgeInsetsMake(125, 0, 0, 0)
        return cv
    }()
    
    let profileBannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 125)
        imageView.image = UIImage.init(named: "todd")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "todd")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let text = UILabel()
        text.text = "Todd LeVasseur"
        text.font =  UIFont(name: "Avenir Next", size: 24.0)
        text.font = UIFont.boldSystemFont(ofSize: 22.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Color.blue
        
        return text
    }()
    
    let positionLabel: UILabel = {
        let text = UILabel()
        text.text = "Todd LeVasseur"
        text.font =  UIFont(name: "Avenir Next", size: 14)
        text.numberOfLines = 2
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Color.red
        
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        view.backgroundColor = .white
        
        nameLabel.text = fellow.name
        positionLabel.text = fellow.position
        profileImage.image = UIImage(named: fellow.profileImage)
        profileBannerView.image = UIImage(named: fellow.profileImage)
        
        collectionView.register(BioCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(profileBannerView)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(blurredEffectView)
        
        setUpViews()
    }
    
    func setUpViews() {
        setUpCollectionView()
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(positionLabel)
        
        profileImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.setAnchor(top: nil, left: profileBannerView.leftAnchor, bottom: profileBannerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 25, paddingBottom: 10, paddingRight: 0)
        nameLabel.setAnchor(top: nil, left: profileImage.rightAnchor, bottom: profileBannerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 25, paddingBottom: 70, paddingRight: 0)
        positionLabel.setAnchor(top: nameLabel.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 8)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 150 - (scrollView.contentOffset.y + 150)
        let height = min(max(y, 60), 400)
        profileBannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let approxWidth = view.frame.width - 15
        let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 18)]
        
        
        let size = CGSize(width: approxWidth, height: 1000)
        
        let estimatedFrameSize = NSString(string: fellow.descriptionText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGSize(width: collectionView.frame.width, height: estimatedFrameSize.height + 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BioCell
        cell.bioTextView.text = fellow.descriptionText
        return cell
    }
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
}
