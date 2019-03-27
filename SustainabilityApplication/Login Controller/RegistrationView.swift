//
//  RegistrationView.swift
//  SLIAPP
//
//  Created by Chandler Long on 6/10/18.
//  Copyright © 2018 College of Charleston. All rights reserved.
//

import UIKit
import Firebase

class RegistrationView: UIView, UIImagePickerControllerDelegate {
    
    let loginController = LoginController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        setUpView()
    }
    
    lazy var cancelButton: UIImageView =  {
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "Back")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let registrationLabel: UILabel = {
        let text = UILabel()
        text.text = "Register"
        text.font =  UIFont(name: "Avenir Next", size: 16.0)
        text.textColor = Color.blue
        
        return text
    }()
    
    let rankTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Class Ranking"
        tf.layer.borderColor = Color.blue.cgColor
        tf.layer.borderWidth = 2
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5.0
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let majorTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Major"
        tf.layer.borderColor = Color.blue.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5.0
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Display Name"
        tf.layer.borderColor = Color.blue.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5.0
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Birthday"
        tf.layer.borderColor = Color.blue.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5.0
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.blue
        button.setTitle("REGISTER", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5.0
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    lazy var maleFemaleSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Male", "Female", "Other"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = Color.blue
        sc.selectedSegmentIndex = 0
        //sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
        return sc
    }()
    
    let justiceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "socialJustice")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setUpView() {
        addSubview(cancelButton)
        addSubview(registrationLabel)
        addSubview(rankTextField)
        addSubview(nameTextField)
        addSubview(majorTextField)
        addSubview(birthdayTextField)
        addSubview(maleFemaleSegmentedControl)
        addSubview(registerButton)
        addSubview(justiceImage)
        
        cancelButton.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        cancelButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        registrationLabel.centerX(centerX: centerXAnchor)
        registrationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
        nameTextField.setAnchor(top: registrationLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        majorTextField.setAnchor(top: nameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        majorTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        rankTextField.setAnchor(top: majorTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        rankTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        birthdayTextField.setAnchor(top: rankTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        birthdayTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        maleFemaleSegmentedControl.setAnchor(top: birthdayTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        maleFemaleSegmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        registerButton.setAnchor(top: maleFemaleSegmentedControl.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        justiceImage.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        justiceImage.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
    }

    @objc func handleRegister() {
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                let width = window.frame.width
                
                self.frame = CGRect(x: -width, y: 0, width: width, height: window.frame.height)
            }
            
        }) { (completed: Bool) in
                        
            let major = self.majorTextField.text!
            let rank = self.rankTextField.text!
            let birthday = self.birthdayTextField.text!
            let name = self.nameTextField.text!

            
            let gender: String!
            
            if self.maleFemaleSegmentedControl.selectedSegmentIndex == 0 {
                gender = "Male"
            } else if self.maleFemaleSegmentedControl.selectedSegmentIndex == 1 {
                gender = "Female"
            } else {
                gender = "Other"
            }
            
            self.loginController.handleRegisterSignIn(name: name, major: major, rank: rank, birthday: birthday, gender: gender)
        }
    }
    
    @objc func handleCancel() {
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                let width = window.frame.width
                
                self.frame = CGRect(x: width + width, y: 0, width: width, height: window.frame.height)
            }
            
        })
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
