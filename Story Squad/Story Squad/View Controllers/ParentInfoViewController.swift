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
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPWTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func doneButton(_ sender: Any) {
        
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTabBarSegue" {
            
            let tabBarController = segue.destination as? UITabBarController
            
			//swiftlint:disable force_cast
            let navVC = tabBarController?.viewControllers![1] as! UINavigationController
            
           let dashboardVC = navVC.topViewController as! DashboardViewController

            dashboardVC.parentUser = self.parentUser
            dashboardVC.networkingController = self.networkingController
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
