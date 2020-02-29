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
            !name.isEmpty,
            let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let confirmPW = confirmPWTextField.text,
            !confirmPW.isEmpty,
            let pin = pinTextField.text,
            !pin.isEmpty
            else { return }
        
        // MARK: - Print Statements
        print(name)
        print(email)
        print(password)
        print(pin)
        
        let pinInt = Int16(pin)
        
        let parent = networkingController.createParent(name: name, email: email, password: password, pin: pinInt!, context: CoreDataStack.shared.mainContext)
        self.parentUser = parent
        performSegue(withIdentifier: "ShowDashboardSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDashboardSegue" {
            
            let navVC = segue.destination as? UINavigationController

			//swiftlint:disable force_cast
			let dashboardVC = navVC?.viewControllers.first as! DashboardViewController
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
