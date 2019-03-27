//
//  SettingsLauncher.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/28/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let backgroundView = UIView()
    let cellId = "cellId"
    var profileController: ProfileController?
    
    let settingsOptions: [Setting] = {
        return [Setting(name: "Edit Profile Picture", imageName: "editPic"), Setting(name: "Edit Banner Image", imageName: "editBanner"), Setting(name: "Edit Current Major", imageName: "editMajor"), Setting(name: "Edit Current Ranking", imageName: "editRank"), Setting(name: "Logout", imageName: "logout"), Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    @objc func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss(_:)))
            backgroundView.addGestureRecognizer(tap)
            backgroundView.isUserInteractionEnabled = true
            
            window.addSubview(backgroundView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settingsOptions.count * 50)
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
    
            backgroundView.frame = window.frame
            backgroundView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backgroundView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.backgroundView.alpha = 0
            
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsOptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settingsOptions[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.backgroundView.alpha = 0
            
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            let option = self.settingsOptions[indexPath.row]
            switch option.name {
            case "Edit Profile Picture":
                print("Going to profile pic")
                
                self.profileController?.changeProfileImage()
                
            case "Edit Banner Image":
                print("Going to banner")
                self.profileController?.changeBannerImage()
                
            case "Edit Current Major":
                print("Going to Major")
                
            case "Edit Current Ranking":
                print("Going to Ranking")
                
            case "Logout":
                let profileController = ProfileController()
                profileController.handleLogout()
            default:
                print("Cancel")
            }
        }
    }
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

class SettingCell: UICollectionViewCell {
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        iconImageView.setAnchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
        iconImageView.centerY(centerY: centerYAnchor)
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
  
        nameLabel.centerY(centerY: centerYAnchor)
        nameLabel.setAnchor(top: nil, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
        
    }
    
    let nameLabel: UILabel = {
        let text = UILabel()
        text.text = "Settings"
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor(r: 140, g: 140, b: 140)
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
        
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "menuProfile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Setting: NSObject {
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
