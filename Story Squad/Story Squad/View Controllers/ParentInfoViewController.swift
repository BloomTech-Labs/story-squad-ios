//
//  ParentInfoViewController.swift
//  Story Squad
//
//  Created by macbook on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ParentInfoViewController: UIViewController {


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
			let emailTextField = emailTextField.text,
			!emailTextField.isEmpty,
			let passwordTextField = passwordTextField.text,
			!passwordTextField.isEmpty,
			let confirmPWTextField = confirmPWTextField.text,
			!confirmPWTextField.isEmpty,
			let pinTextField = pinTextField.text,
			!pinTextField.isEmpty
			else { return }

    // MARK: - Print Statements
		print(name)
		print(emailTextField)
		print(passwordTextField)
		
        print(pinTextField)
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
