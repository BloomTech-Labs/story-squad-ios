//
//  FamilySettingsViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class FamilySettingsViewController: UIViewController {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    
    
    // MARK: - Outlets
    @IBOutlet weak var enterNewEmailTextField: UITextField!
    @IBOutlet weak var enterOldPasswordTextField: UITextField!
    @IBOutlet weak var enterNewPasswordTextField: UITextField!
    @IBOutlet weak var reEnterNewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromSignup()
    }

    // To receive the Parent and NetworkingController from the Tab Bar
    func receiveDataFromSignup() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.parentUser = tabBar.parentUser
        self.networkingController = tabBar.networkingController
    }
    
    @IBAction func addChildButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        showCompleteAlert()
    }
    
// MARK: - Alert for Update Complete
    func showCompleteAlert() {
        let alert = UIAlertController(title: "Family Settings", message: "Update Complete", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "ManageChildProfilesSegue" {
            guard let manageChildProfilesVC = segue.destination as? ManageChildProfilesViewController else { return }
            manageChildProfilesVC.parentUser = self.parentUser
            manageChildProfilesVC.networkingController = self.networkingController
            
           } else if segue.identifier == "toAddChildSegue" {
            guard let addChildVC = segue.destination as? AddChildViewController else { return }
            addChildVC.parentUser = self.parentUser
            addChildVC.networkingController = self.networkingController
            
           }
       }
}
