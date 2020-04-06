//
//  ChildProfileCollectionViewCell.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildProfileCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var childUser: Child? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var profileCardBlueView: UIView!
    @IBOutlet weak var viewProfileLabel: UILabel!
    
    // MARK: - Methods
    
    private func updateViews() {
        
        profileCardBlueView.layer.cornerRadius = 10
        viewProfileLabel.layer.masksToBounds = true
        viewProfileLabel.layer.cornerRadius = 10
        
        guard let child = childUser,
            let avatar = child.avatar else { return }
        
        //nameLabel.text = child.name
        
        if let username = child.username {
            nameLabel.text = username
        } else {
            nameLabel.text = child.name
        }
        
        avatarImageView.image = UIImage(named: avatar)
        }
    }
