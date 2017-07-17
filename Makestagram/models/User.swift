//
//  User.swift
//  Makestagram
//
//  Created by Anika Kablan on 6/28/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
import FirebaseAuth
class User: NSObject{
    
    var isFollowed = false
    //MARK : - Properties
    let uid: String
    let username: String
    
    //Mark: - Init
    init(uid: String, username: String){
        self.uid = uid
        self.username = username
        super.init()
    }
        
     init?(snapshot: DataSnapshot) {
            guard let dict = snapshot.value as? [String : Any],
                let username = dict["username"] as? String
                else{return nil}
            
        self.uid = snapshot.key
        self.username = username
        
        if let user = Auth.auth().currentUser{
            
            let rootRef = Database.database().reference()
            
            let userRef = rootRef.child("users").child(user.uid)
            userRef.setValue(["username": username])
            userRef.observeSingleEvent(of: .value, with:{
                (snapshot) in
                
                if let userDict = snapshot.value as? [String : Any]{
                    print(userDict.debugDescription)
                }
            })
                }

        
        super.init()
        
    }
    required init?(coder aDecoder: NSCoder){
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            
            else {
                return nil
        
        }
        self.uid = uid
        self.username = username
        
        super.init()
    }

    //1
    private static var _current: User?
    
    //2
    static var current: User {
        //3
        guard let currentUser = _current else {
            fatalError ("Error: current user doesn't exist")
        }
        //4
        return currentUser
        
    
        
    }
    
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false){
        
        if writeToUserDefaults{
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            UserDefaults.standard.set(data,forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }
    //Mark- Class Methods
    
    //5
//    static func setCurrent( _ user: User){
//        _current = user
//
//    }
   }

extension User: NSCoding{
    func encode(with aCoder: NSCoder){
    aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
    aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
    
  }
