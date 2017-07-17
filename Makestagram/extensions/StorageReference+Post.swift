//
//  StorageReference+Post.swift
//  Makestagram
//
//  Created by Anika Kablan on 6/30/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newsPostImageReference() -> StorageReference{
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
}
