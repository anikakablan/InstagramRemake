//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Anika Kablan on 7/3/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell {
    
    weak var delegate: PostActionCellDelegate?

    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCount: UILabel!
    
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    static let height: CGFloat = 46
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }

  
}
