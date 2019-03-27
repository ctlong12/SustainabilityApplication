//
//  LoginController.swift
//  SLIApp
//
//  Created by Chandler Long on 6/20/18.
//  Copyright © 2018 College of Charleston. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        view.addSubview(backGroundView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(cofcImageView)
        view.addSubview(captionLabel)
        view.addSubview(guestButton)
        
        setUpBackground()
        setUpEmailTextField()
        setUpPasswordTextField()
        setUpLoginButton()
    }
    
    let captionLabel: UILabel = {
        let text = UILabel()
        text.text = "Sign in using your College of Charelston,\nCougar Id!"
        text.font = UIFont(name: "AvenirNext", size: 12)
        text.font = UIFont.boldSystemFont(ofSize: 12)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.textColor = UIColor.white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .center
        
        return text
        
    }()
    
    let emailTextField: UITextField = {
        let emailTextFeild = UITextField()
        emailTextFeild.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        emailTextFeild.font = UIFont(name: "AvenirNext", size: 20)
        emailTextFeild.font = UIFont.boldSystemFont(ofSize: 20)
        emailTextFeild.textColor = UIColor.white
        emailTextFeild.textAlignment = .center
        emailTextFeild.borderStyle = UITextBorderStyle.bezel
        emailTextFeild.layer.cornerRadius = 25.0
        emailTextFeild.layer.borderWidth = 2.0
        emailTextFeild.borderStyle = .none
        emailTextFeild.layer.borderColor = UIColor.white.cgColor
        emailTextFeild.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        emailTextFeild.translatesAutoresizingMaskIntoConstraints = false
        
        return emailTextFeild
        
    }()
    
    let passwordTextField: UITextField = {
        let passwordTextFeild = UITextField()
        passwordTextFeild.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        passwordTextFeild.font = UIFont(name: "AvenirNext", size: 20)
        passwordTextFeild.font = UIFont.boldSystemFont(ofSize: 20)
        passwordTextFeild.textColor = UIColor.white
        passwordTextFeild.textAlignment = .center
        passwordTextFeild.borderStyle = UITextBorderStyle.bezel
        passwordTextFeild.layer.cornerRadius = 25.0
        passwordTextFeild.layer.borderWidth = 2.0
        passwordTextFeild.borderStyle = .none
        passwordTextFeild.isSecureTextEntry = true
        passwordTextFeild.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        passwordTextFeild.layer.borderColor = UIColor.white.cgColor
        passwordTextFeild.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordTextFeild
        
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.backgroundColor = Color.blue

        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font =  UIFont(name: "AvenirNext", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.layer.borderWidth = 2.0
        //button.layer.borderColor = UIColor.white.cgColor
        
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return button
    }()
    
    lazy var guestButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.backgroundColor = Color.yellow
        
        button.setTitle("Continue as Guest", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font =  UIFont(name: "AvenirNext", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.layer.borderWidth = 2.0
        //button.layer.borderColor = UIColor.white.cgColor
        
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return button
    }()
    
    let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.opacity = 0.75
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let cofcImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cofc")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setUpBackground() {
        backGroundView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        backGroundView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    
    func setUpEmailTextField() {
        cofcImageView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        cofcImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: cofcImageView.bottomAnchor, constant: 75).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpPasswordTextField() {
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpLoginButton() {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        captionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        captionLabel.centerYAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        
        
        guestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guestButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        guestButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        guestButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
