//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Anika Kablan on 6/27/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User


class LoginViewController: UIViewController {
    
    
    
    
    // properties
    @IBOutlet weak var loginButton: UIButton!
    
    
    //lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        //1
        guard let authUI = FUIAuth.defaultAuthUI()
            else {return}
        
        //2
        authUI.delegate = self
        
        //3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    
    
}

extension LoginViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?){
        if let error = error{
            assertionFailure("Error signing in:\(error.localizedDescription)")
        }
        
        guard let user = user
            else { return }
        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        // 3
        userRef.observeSingleEvent(of: .value, with: {  [unowned self] (snapshot) in
            // 4 retrieve user data from snapshot
            
            if let user = User(snapshot: snapshot) {
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
                print ("Welcome back, \(user.username).")
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
                
            }
        })
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                
                User.setCurrent(user)
               let storyboard = UIStoryboard(name: "Main", bundle: .main)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        })
    }
}


