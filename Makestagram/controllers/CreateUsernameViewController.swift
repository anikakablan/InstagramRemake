//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Anika Kablan on 6/29/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuthUI

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nextButton.layer.cornerRadius = 6
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //1
        //First you guard to check that a FIRUser is logged in and that the user has provided a username in the text field
        
        guard let firUser = Auth.auth().currentUser,
        let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                return
            }
           
            User.setCurrent(user, writeToUserDefaults: true)
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
        //2
        // we create a dictionary to store the username th user has provided inside our database
        let userAttrs = ["username": username]
        
        //3
        // we specify a relative path for the location of where we want to store our data
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        //4
        //we wrote the data we want to store at the ;ocation we provideed in step 3
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            
         //5
            //we read the user we just wrote tot the database and creat a user from the snapshot
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                
                //handle newly created user here
        
    })
        
   
    
           }
    }
    
}

