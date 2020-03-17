//
//  ParentInfoViewController.swift
//  Story Squad
//
//  Created by macbook on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseFirestore

class SignupViewController: UIViewController {
    
    // MARK: - Properties
    let networkingController = NetworkingController()
    var parentUser: Parent?
    var bearerToken: Bearer?
    
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
        .strokeWidth: -3.5
    ]
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: PaddedTextField!
    @IBOutlet weak var emailTextField: PaddedTextField!
    @IBOutlet weak var passwordTextField: PaddedTextField!
    
    @IBOutlet weak var confirmPWTextField: PaddedTextField!
    @IBOutlet weak var pinTextField: PaddedTextField!
    
    @IBOutlet weak var storySquadLabel: UILabel!
    @IBOutlet weak var alredyHaveAccountLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinTextField.delegate = self
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)   
    }
    
    // MARK: - Actions
    @IBAction func signUpButton(_ sender: Any) {
//        self.navigationController.setRoo
        signupParentAccount()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        // "GoToLoginFromSignupSegue"
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func signupParentAccount() {
        
        // Validate the fields, or save error mesage to display
        let validateErrorMessage = validateFields()
        
        if validateErrorMessage != nil {
            showErrorAlert(errorTitle: "Oops!", errorMessage: validateErrorMessage!)
            
        } else {
            
            // Grab Parent info
            guard let password = passwordTextField.text,
                let email = emailTextField.text,
                let name = nameTextField.text,
                let confirmPW = confirmPWTextField.text else { return }
            
            // Check if password textFields match
            if password != confirmPW {
                showPasswordsMismatchAlert()
                
            } else {
                
                // Try Signup Parent Account
                networkingController.signupParent(email: email, password: password, termsOfService: true, name: name) { (result) in
                    do {
                        let result = try result.get()
                        self.bearerToken = result
//                        self.parentUser = self.networkingController.parentUser
                        // let parentRepresentation = result
                        //print("Parent Representation result: \(String(describing: parentRepresentation))")
                        
                        DispatchQueue.main.async {
                            
                            if let parent = self.networkingController.parentUser {
                                
                                self.parentUser = parent
                                self.performSegue(withIdentifier: "ShowTabBarSegue", sender: self)
                            } else {
                                self.showErrorAlert(errorTitle: "Oops!", errorMessage: "Couldn't get all necessary data. Please try again")
                                NSLog("Some of the data is not complete")
                            }
                        }
                    } catch {
                        print("Didn't get a succesfull Result")
                        
                        DispatchQueue.main.async {
                            self.showErrorAlert(errorTitle: "Signup unseccessful", errorMessage: "Please check your credentials and try again")
                        }
                    }
                }
            }
        }
    }
    
    func showErrorAlert(errorTitle: String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPWTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // TODO: Comment back in for production
        
        //        // Check if the password is secure enough
        //        if isPasswordValid(cleanedPassword) == false {
        //
        //            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        //        }
        return nil
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        // 1 - Password length is 8.
        // 2 - One Alphabet in Password.
        // 3 - One Special Character in Password.
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: - Password missMatch
    func showPasswordsMismatchAlert() {
        let alert = UIAlertController(title: "Passwords don't match", message: "Please check passwords entries and try again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - Incomplete Child Data Alert
    func showIncompleteAlert() {
        let alert = UIAlertController(title: "Incomplete Account Information", message: "Please fill in all text fields", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - Update Views
    func updateViews() {
        
        // Hiding the Navigation tab bar
        navigationController?.navigationBar.isHidden = true
        
        let pumkinStrokeAttribute = NSAttributedString(string: storySquadLabel.text!, attributes: sqLabelStrokeAttributes)
        
        storySquadLabel.attributedText = pumkinStrokeAttribute
        storySquadLabel.textColor = UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1)
        
        nameTextField.layer.borderWidth = 0.175
        emailTextField.layer.borderWidth = 0.175
        passwordTextField.layer.borderWidth = 0.175
        confirmPWTextField.layer.borderWidth = 0.175
        pinTextField.layer.borderWidth = 0.175
        
        nameTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        emailTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        passwordTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        confirmPWTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
        pinTextField.layer.borderColor = UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1).cgColor
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTabBarSegue" {
            
            // Removing the previous Navigation Controller
            guard let navigationController = self.navigationController else { return }
            var navigationArray = navigationController.viewControllers // To get all the previous NavControllers as an Array
            navigationArray.removeAll() // To remove all UIViewControllers out of this Array
            self.navigationController?.viewControllers = navigationArray // Setting this array as the navigationController?.viewControllers
            
            guard let tabBarController = segue.destination as? MainTabBarController else { return }
            
            tabBarController.parentUser = self.parentUser
            tabBarController.networkingController = self.networkingController
        }
    }
}

// MARK: - Pin TextField Properties Function
extension SignupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 4
        let currentString: NSString = pinTextField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
