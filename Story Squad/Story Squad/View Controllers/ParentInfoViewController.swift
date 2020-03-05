//
//  ParentInfoViewController.swift
//  Story Squad
//
//  Created by macbook on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ParentInfoViewController: UIViewController {
    
    // MARK: - Properties
    let networkingController = NetworkingController()
    var parentUser: Parent?
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
         .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
         .strokeWidth: -3.5
     ]
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: SignUpTextField!
    @IBOutlet weak var emailTextField: SignUpTextField!
    @IBOutlet weak var passwordTextField: SignUpTextField!
    
    @IBOutlet weak var confirmPWTextField: SignUpTextField!
    @IBOutlet weak var pinTextField: SignUpTextField!
    
    @IBOutlet weak var storySquadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinTextField.delegate = self
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPW = confirmPWTextField.text,
            let pin = pinTextField.text,
            !name.isEmpty,
            !email.isEmpty,
            !password.isEmpty,
            !confirmPW.isEmpty,
            !pin.isEmpty else { return }
        
        // MARK: - Print Statements
        print(name)
        print(email)
        print(password)
        print(pin)
        
        let pinInt = Int16(pin)
        
        let parent = networkingController.createParent(name: name, email: email, password: password, pin: pinInt!, context: CoreDataStack.shared.mainContext)
        self.parentUser = parent
        performSegue(withIdentifier: "ShowTabBarSegue", sender: self)
    }
    
    // MARK: - Update Views
    func updateViews() {
        
        let pumkinStrokeAttribute = NSAttributedString(string: storySquadLabel.text!, attributes: sqLabelStrokeAttributes)
        
        storySquadLabel.attributedText = pumkinStrokeAttribute
        storySquadLabel.textColor = UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1)
        
        nameTextField.layer.borderWidth = 0.25
        emailTextField.layer.borderWidth = 0.25
        passwordTextField.layer.borderWidth = 0.25
        confirmPWTextField.layer.borderWidth = 0.25
        pinTextField.layer.borderWidth = 0.25
        
        nameTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        emailTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        passwordTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        confirmPWTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        pinTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTabBarSegue" {
            
            let tabBarController = segue.destination as? UITabBarController
            
			//swiftlint:disable force_cast
            let navVC = tabBarController?.viewControllers![1] as! UINavigationController
            
//            let mainTabBarVC = navVC.topViewController as! MainTabBarController
//            mainTabBarVC.parentUser = self.parentUser
//            mainTabBarVC.networkingController = self.networkingController
            
           let dashboardVC = navVC.topViewController as? DashboardViewController

            dashboardVC?.parentUser = self.parentUser
            dashboardVC?.networkingController = self.networkingController
            
//            let settingsVC = navVC.topViewController as? SettingsParentPinViewController
//
//            settingsVC?.parentUser = self.parentUser
//            settingsVC?.networkingController = self.networkingController
        }
    }
}

// MARK: - Pin TextField Properties Function
extension ParentInfoViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 4
        let currentString: NSString = pinTextField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        // Mobile validation
        //        if textField == pinTextField {
        //            let allowedCharacters = CharacterSet(charactersIn: "0123456789")//Here change this characters based on your requirement
        //            let characterSet = CharacterSet(charactersIn: string)
        //            return allowedCharacters.isSuperset(of: characterSet)
        //        }
        return newString.length <= maxLength
    }
}
