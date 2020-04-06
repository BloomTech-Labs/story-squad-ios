//
//  LogInViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    let networkingController = NetworkingController()
    var parentUser: Parent?
    var childUser: Child?
    
    var parentToken: Bearer?
    
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
        
        // Hide the Keyboard with tap gesture
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - IBActions
    @IBAction func signInButtonTapped(_ sender: Any) {
        login()
    }
    
    func login() {
        
        // Validate the fields, or save error mesage to display
        let error = validateFields()
        
        if error != nil {
            showErrorAlert(errorTitle: "Sorry", errorMessage: error!)
        } else {
            
            // Clean version of data entry
            guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            
            // Try Login
            networkingController.loginParent(email: email, password: password) { (result) in
                
                do {
                    
                    // Set bearer and parentUser
                    let result = try result.get()
                    self.parentToken = result
                    
                    DispatchQueue.main.async {
                        
                        if let _ = self.networkingController.parentUser {
                            
                            let parent = self.networkingController.parentUser
                            self.parentUser = parent
                            
                            // Ask if the Parent or a Child is logging in
                            self.askWhoWillLogin()
                            
                        } else {
                            // TODO: If this alert NEVER shows up after a few days:
                            // We delete this "if let _ = self.networkingController.parentUser" if-else clause
                            self.showErrorAlert(errorTitle: "Oops!", errorMessage: "Couldn't get all necessary data. Please try again")
                            NSLog("Couldn't get response from server.")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showErrorAlert(errorTitle: "Unsuccessful Login", errorMessage: "Please check your credentials and try again.")
                    }
                }
            }
        }
    }
    
    private func askWhoWillLogin() {
        
        let alert = UIAlertController(title: "Ready!", message: "Who will Sign in today?", preferredStyle: .alert)
        
        guard let parent = parentUser else { return }

        // Action buttons
        alert.addAction(UIAlertAction(title: "Parent", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "ShowTabBarFromLoginSegue", sender: self)
        }))
        
        // Fetch Children in CoreData for this Parent
        let children = networkingController.fetchChildrenFromCDFor(parent: parent)
        
        // Add a button for each child
        for child in children {
            guard let name = child.name else { return }
            
            alert.addAction(UIAlertAction(title: "\(name)", style: .default, handler: { (_) in
                print(("\n\n Tapped on child \(name)\n\n"))
                self.childUser = child
                self.loginChildAlert(child: child)
            }))
        }
        
        // present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loginChildAlert(child: Child) {
        
        let alert = UIAlertController(title: "Log In", message: "Please enter your PIN", preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "Login", style: .default, handler: { (_) -> Void in
            
            self.networkingController.loginChild(child: child) { (result) in
                
                do {
                    let result = try result.get()
                    
                    DispatchQueue.main.async {
                        if result != nil {
                            self.performSegue(withIdentifier: "ShowChildDashboardVCFromLoginVC", sender: self)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showErrorAlert(errorTitle: "Unsuccessful Login", errorMessage: "Please check your username or PIN and try again ")
                    }
                }
            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        // 1st TextField for username
        alert.addTextField { (textField: UITextField) in
            
            if let username = child.username {
                
                textField.text = "\(username)"
                textField.keyboardType = .default
            } else {
                textField.placeholder = "Enter username"
                textField.keyboardType = .default
            }
        }
        
        // 2nd textField for password
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter PIN"
            textField.isSecureTextEntry = true
        }

        // Add actions
        alert.addAction(loginAction)
        alert.addAction(cancel)
        
        // present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showErrorAlert(errorTitle: String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    // Clear out TextFileds before segue from this VC
    private func clearOutTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func updateViews() {
        
        // Hide NavigationController Bar
        navigationController?.navigationBar.isHidden = true
        
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
    
    // TODO: This function should run at viewDidLoad, when finished ( WIP Function)
    func checkBearerIsValid() {
        
//        guard let bearer = UserDefaults.standard.string(forKey: .parentBearerString),
//            let email = UserDefaults.standard.string(forKey: .parentEmailString),
//            let password = UserDefaults.standard.string(forKey: .parentPassString) else { return }
        
        // Make a network call to check if the token is still valid
        // If Bearer is valid, automatically login
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to TabBar
        if segue.identifier == "ShowTabBarFromLoginSegue" {
            clearOutTextFields()
            
            guard let tabBarController = segue.destination as? MainTabBarController else { return }
            
            tabBarController.parentUser = self.parentUser
            tabBarController.networkingController = self.networkingController
        }
        // Segue to Child Dashboard
        else if segue.identifier == "ShowChildDashboardVCFromLoginVC" {
            clearOutTextFields()
            
            guard let tabBarController = segue.destination as? ChildTabBarController else { return }
            
            tabBarController.parentUser = self.parentUser
            tabBarController.childUser = networkingController.childUser
            tabBarController.networkingController = self.networkingController
        }
    }
}
