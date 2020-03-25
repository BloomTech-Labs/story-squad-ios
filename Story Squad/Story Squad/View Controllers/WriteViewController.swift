//
//  WriteViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?
    
    // MARK: - Outlets
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var writeTextView: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chooseFilesFromDeviceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        
        // Hide Keyboard on tap gesture
        self.hideKeyboardWhenTappedAround()
    }
    
    func updateViews() {
        promptLabel.layer.borderWidth = 7.0
        writeTextView.layer.cornerRadius = 10
        writeTextView.layer.borderWidth = 3.0
        chooseFilesFromDeviceButton.layer.borderWidth = 3.0
        submitButton.layer.borderWidth = 3.0
        
        writeTextView.text = ""
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
