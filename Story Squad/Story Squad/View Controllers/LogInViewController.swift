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
    var bearerToken: Bearer?
    
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
                    self.bearerToken = result
                    
                    DispatchQueue.main.async {
                        
//                        if let parent = self.networkingController.parentUser {
                        
                            let parent = self.networkingController.parentUser
                            self.parentUser = parent
                            self.performSegue(withIdentifier: "ShowTabBarFromLoginSegue", sender: self)
                        
//                        } else {
//                            self.showErrorAlert(errorTitle: "Oops!", errorMessage: "Couldn't get all necessary data. Please try again")
//                            NSLog("Couldn't get response from server.")
//                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showErrorAlert(errorTitle: "Unsuccessful Login", errorMessage: "Please check your credentials and try again.")
                    }
                }
            }
        }
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to TabBar
        if segue.identifier == "ShowTabBarFromLoginSegue" {
            
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
