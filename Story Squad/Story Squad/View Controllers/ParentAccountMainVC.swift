//
//  ParentAccountMainVC.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ParentAccountMainVC: UIViewController {

    // MARK: - Properties
    
    var networkingController: NetworkingController?
    var parentUser: Parent?
    
    // MARK: - Outlets
    
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        guard let newEmail = newEmailTextField.text,
            !newEmail.isEmpty,
            let currentPassword = currentPasswordTextField.text,
            !currentPassword.isEmpty,
            let newPassword = newPasswordTextField.text,
            !newPassword.isEmpty
            else { return }
    }
    @IBAction func addEditCardButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func cancelAccountButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func termsConditionButtonTapped(_ sender: UIButton) {
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
