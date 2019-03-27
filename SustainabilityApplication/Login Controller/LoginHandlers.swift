//
//  LoginHandlers.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/30/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Firebase

extension LoginController {
    
    
    @objc func handleSignIn() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    print("You have signed in correctly")
                    self.handleSignIn()
                } else {
                    print("There was an error")
                    print(error)
                }
            }
        }
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let uid = user?.user.uid else {
                return
            }
            
            let ref = Database.database().reference()
            
            let usersReference = ref.child("users").child(uid)
            let values = ["email": email] as [String : Any]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print(err)
                    return
                }
            })
        })
        handleGoToRegister()
    }
    
    @objc func handleGoToRegister() {
        let registrationView = RegistrationView(frame:  UIScreen.main.bounds)
        registrationView.frame = CGRect(x: view.frame.width + view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(registrationView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                let width = window.frame.width
                
                registrationView.frame = CGRect(x: 0, y: 0, width: width, height: window.frame.height)
            }
            
        }, completion: nil)
    }
    
    @objc func handleRegisterSignIn(name: String, major: String, rank: String, birthday: String, gender: String) {
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        let usersReference = ref.child("users").child(uid!)
        let values = ["name": name, "major": major, "classRank": rank, "birthday": birthday, "gender": gender, "profileImageUrl": nil] as [String : Any]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            let root = UIApplication.shared.keyWindow!.rootViewController!
            root.dismiss(animated: true, completion: nil)
        })
    }
    
}


