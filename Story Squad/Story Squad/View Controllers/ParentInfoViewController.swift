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

        // Do any additional setup after loading the view.
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

		// Just for testing
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
