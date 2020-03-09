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
        
        DispatchQueue.main.async {
            self.cntView.layer.shadowColor = UIColor.gray.cgColor
            self.cntView.layer.shadowOpacity = 0.5
            self.cntView.layer.shadowOpacity = 10.0
            self.cntView.layer.shadowOffset = .zero
            self.cntView.layer.shadowPath = UIBezierPath(rect: self.cntView.bounds).cgPath
            self.cntView.layer.shouldRasterize = true
        }
    }

}
