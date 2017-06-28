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

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    
     typealias aliasName = existingType
    
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
            return
        }
    
        print("handle user signup / login")
    }
    
    let user: FIRUser? = Auth.auth().currentUser
}
