//
//  LogInViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    // MARK: - Properties
    let networkingController = NetworkingController()
    var parentUser: Parent?
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
         .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
         .strokeWidth: -3.5
     ]
    
    // MARK: - Outlets
    
    @IBOutlet weak var storySquadLabel: UILabel!
    @IBOutlet weak var emailTextField: PaddedTextField!
    @IBOutlet weak var passwordTextField: PaddedTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
    // TODO: Remove when functionality is there for Forgot Password
    forgotPasswordButton.alpha = 0
        
    let pumkinStrokeAttribute = NSAttributedString(string: storySquadLabel.text!, attributes: sqLabelStrokeAttributes)
    
    storySquadLabel.attributedText = pumkinStrokeAttribute
    storySquadLabel.textColor = UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1)
    emailTextField.layer.borderWidth = 0.175
    passwordTextField.layer.borderWidth = 0.175
    emailTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
    passwordTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTabBarSegue" {
            guard let tabBarController = segue.destination as? MainTabBarController else { return }
            
            tabBarController.parentUser = self.parentUser
            tabBarController.networkingController = self.networkingController
        }
    }

}
