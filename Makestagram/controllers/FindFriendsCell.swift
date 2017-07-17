//
//  FindFriendsCell.swift
//  Makestagram
//
//  Created by Anika Kablan on 7/5/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import UIKit

protocol FindFriendsCellDelegate: class {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell)
}


class FindFriendsCell: UITableViewCell {
    
    weak var delegate: FindFriendsCellDelegate?
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!

    override func awakeFromNib() {
        
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func folllowButtonTapped(_ sender: UIButton) {
        delegate?.didTapFollowButton(sender, on: self)
    }

   
}
