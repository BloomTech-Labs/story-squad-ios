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
    
    // MARK: - Methods
    
    private func updateViews() {
        
        guard let child = childUser else { return }
        
        nameLabel.text = child.name
//        teamLabel.text = child.cohort
        
        // Setting Child avatar if not nil
        if let avatar = child.avatar {
            let avatarImage = UIImage(data: avatar)
            avatarImageView.image = avatarImage
        }
    }
}
