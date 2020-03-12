//
//  LogInViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: UIViewController {

    // MARK: - Properties
    let networkingController = NetworkingController()
    var parentUser: Parent?
    
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
        checkLoginStatus()
    }
    
    // MARK: - IBActions
    @IBAction func signInButtonTapped(_ sender: Any) {
//        performSegue(withIdentifier: "ShowTabBarSegue", sender: self)
        
        login()
    }
    
    // Automatically Log in if tocken is valid
    func checkLoginStatus() {
        if UserDefaults.standard.object(forKey: "token") != nil {
            performSegue(withIdentifier: "ShowTabBarFromLoginSegue", sender: self)
        } else {
            return
        }
    }
    
    func login() {
        
        // Validate the fields, or save error mesage to display
        let error = validateFields()
        
        if error != nil {
            showErrorAlert(errorMessage: error!)
        } else {
            
            // Clean version of data entry
            guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            
            Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
                self.networkingController.getCredentials()
                
                if let err = err {
                    self.showErrorAlert(errorMessage: "Unsuccessful Login: \(err.localizedDescription)")
                    NSLog("Error trying to login: \(err)")
                    
                } else {
                    self.performSegue(withIdentifier: "ShowTabBarFromLoginSegue", sender: self)
                }
            }
        }
    }
    
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Oops!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateFields() -> String? {
        
//        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
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
    
    func updateViews() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTabBarFromLoginSegue" {
            guard let tabBarController = segue.destination as? MainTabBarController else { return }
            
            guard let userID = networkingController.userID,
                let parent = networkingController.fetchParentFromCD(with: userID) else { return }
            
//            self.parentUser = parent
            
            tabBarController.parentUser = parent
            tabBarController.networkingController = self.networkingController
        }
    }
}
