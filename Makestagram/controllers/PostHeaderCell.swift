//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Anika Kablan on 7/3/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let height: CGFloat = 54

    override func awakeFromNib() {
    
        super.awakeFromNib()

        // Do any additional setup after loading the view.
    }

    @IBAction func optionsButtonTapped(_ sender: Any) {
        print(" options button tapped")
    }
    

}
