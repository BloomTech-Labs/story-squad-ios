//
//  ChildCollectionViewCell.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var childSettingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
            self.cntView.layer.cornerRadius = 14.0
            self.cntView.layer.shouldRasterize = true
            self.childSettingsLabel.layer.cornerRadius = 14.0
    }

}
