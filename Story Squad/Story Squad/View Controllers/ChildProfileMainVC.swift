//
//  ChildProfileMainVC.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildProfileMainVC: UIViewController {
    
    // MARK: - Properties
    
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?

    @IBOutlet weak var comingSoonLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        comingSoonLabel.transform = CGAffineTransform.init(rotationAngle: 0.75)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
