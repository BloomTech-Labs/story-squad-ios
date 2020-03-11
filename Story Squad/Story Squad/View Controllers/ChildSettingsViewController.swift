//
//  ChildSettingsViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildSettingsViewController: UIViewController {
   
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var pinConfirmationTextField: UITextField!
    @IBOutlet weak var dyslexiaSlider: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        receiveDataFromSignup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
   }
    func receiveDataFromSignup() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        self.parentUser = tabBar.parentUser
        self.networkingController = tabBar.networkingController
    }
    
    @IBAction func dyslexiaSliderToggled(_ sender: UISwitch) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        showCompleteAlert()
            }
            
        // MARK: - Alert for Update Complete
            func showCompleteAlert() {
                let alert = UIAlertController(title: "Child Settings", message: "Update Complete", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
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
