//
//  ProfileController.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/15/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Foundation
import FirebaseStorage
import Firebase

class ProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let backgroundView = UIView()
    var editBanner = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        //view.addSubview(ProfileView(frame: view.frame))
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        view.backgroundColor = Color.backgroundColor
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(profileBannerView)
        view.addSubview(opacityLayer)
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        setUpCollectionView()
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary  = snapshot.value as? [String: AnyObject] {
                self.nameLabel.text = dictionary["name"] as? String
                
                let urlProfileImage = dictionary["profileImageUrl"] as? String
                if urlProfileImage != nil {
                    self.profileImage.loadImageUsingCacheWithUrlString(urlProfileImage!)
                }
                
                let urlProfileBanner = dictionary["profileBannerUrl"] as? String
                if urlProfileBanner != nil {
                    self.profileBannerView.loadImageUsingCacheWithUrlString(urlProfileBanner!)
                }
            }
            
        }, withCancel: nil)
        
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(dismissProfileController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(displaySettings))
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher  = SettingsLauncher()
        launcher.profileController = self

        return launcher
    }()
    
    @objc func displaySettings() {
        settingsLauncher.showSettings()
    }
    
    func handleLogout() {
        let loginController = LoginController()
        let root = UIApplication.shared.keyWindow!.rootViewController!
        root.present(loginController, animated: true, completion: nil)
    }
    
    @objc func dismissProfileController() {
        dismiss(animated: true, completion: nil)
    }
    
   @objc func changeProfileImage() {
        let picker = UIImagePickerController()
    present(picker, animated: true, completion: nil)
        
        picker.delegate = self
        picker.allowsEditing = true
    }
    
    @objc func changeBannerImage() {
        editBanner = true
        let bannerPicker = UIImagePickerController()
        present(bannerPicker, animated: true, completion: nil)
        
        bannerPicker.delegate = self
        bannerPicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            print(editedImage.size)
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
            selectedImageFromPicker = originalImage
            
        }
        
        if let selectedImage = selectedImageFromPicker {
            if editBanner == true {
                editBanner = false
                //profileBannerView.image = selectedImage
                uploadProfileImageBanner(image: selectedImage)
            } else {
                //profileImage.image = selectedImage
                uploadProfileImageToFirebaseStorage(image: selectedImage)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileImageToFirebaseStorage(image: UIImage) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("ProfileImages").child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                let ref = Database.database().reference()
                let uid = Auth.auth().currentUser?.uid
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print(error)
                        return
                    } else {
                        let usersReference = ref.child("users").child(uid!)
                        let values = ["profileImageUrl": url!.absoluteString] as [String : Any]
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if let err = err {
                                print(err)
                                return
                            }
                            self.refreshProfile(url: "profileImageUrl")
                        })
                    }
                }
            }
        }
    }
    
    func uploadProfileImageBanner(image: UIImage) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("BannerImages").child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                let ref = Database.database().reference()
                let uid = Auth.auth().currentUser?.uid
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print(error)
                        return
                    } else {
                        let usersReference = ref.child("users").child(uid!)
                        let values = ["profileBannerUrl": url!.absoluteString] as [String : Any]
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if let err = err {
                                print(err)
                                return
                            }
                            self.refreshProfile(url: "profileBannerUrl")
                        })
                    }
                }
            }
        }
    }
    
    func refreshProfile(url: String) {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary  = snapshot.value as? [String: AnyObject] {
                
                let urlProfileBanner = dictionary["\(url)"] as? String
                if urlProfileBanner != nil {
                    if url == "profileBannerUrl" {
                        self.profileBannerView.loadImageUsingCacheWithUrlString(urlProfileBanner!)
                    } else {
                        self.profileImage.loadImageUsingCacheWithUrlString(urlProfileBanner!)
                    }
                }
            }
        }, withCancel: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.contentInset = UIEdgeInsetsMake(195, 0, 0, 0)
        return cv
    }()
    
    let profileBannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 215)
        imageView.image = UIImage.init(named: "test")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let opacityLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    let nameLabel: UILabel = {
        let text = UILabel()
        text.text = "Chandler Long"
        text.font =  UIFont(name: "Avenir Next", size: 18.0)
        text.numberOfLines = 2
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        
        return text
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 150 - (scrollView.contentOffset.y + 150)
        let height = min(max(y, 60), 600)
        profileBannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        opacityLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        profileImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        profileImage.centerX(centerX: view.centerXAnchor)
        nameLabel.setAnchor(top: profileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        nameLabel.centerX(centerX: view.centerXAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 603)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCell
        return cell
    }
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
}
