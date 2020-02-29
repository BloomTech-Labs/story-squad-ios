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
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var dashboardIconSetImageView: UIImageView!
    
    // MARK: - Methods
    
    private func updateViews() {
        missionLabel.layer.cornerRadius = CGFloat(5)
        
        guard let child = childUser else { return }
        
        nameLabel.text = child.name
//        teamLabel.text = child.cohort
        
        if let avatarImage = UIImage(data: child.avatar!) {
            avatarImageView.image = avatarImage
        }
    }
}
