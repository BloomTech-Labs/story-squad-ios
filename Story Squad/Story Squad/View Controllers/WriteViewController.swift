//
//  WriteViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?
    
    // MARK: - Outlets
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var writeTextView: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chooseFilesFromDeviceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        
        // Hide Keyboard on tap gesture
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        if let _ = childUser,
            let writtenStory = writeTextView.text,
            !writtenStory.isEmpty {
            
            showStorySubmittedAlert()
//            self.dismiss(animated: true, completion: nil)
        } else {
            showErrorAlert(errorTitle: "No Story found", errorMessage: "Please write your story before submitting")
        }
    }
    
    @IBAction func chooseFilesFromDeviceButtonTapped(_ sender: UIButton) {
    }
    
    // Story Submitted Alert
    private func showStorySubmittedAlert() {
        
        let alert = UIAlertController(title: "Your Amazing Story has been Submitted!", message: "Thank you", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Error alert
    private func showErrorAlert(errorTitle: String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateViews() {
        promptLabel.layer.borderWidth = 7.0
        writeTextView.layer.cornerRadius = 10
        writeTextView.layer.borderWidth = 3.0
        chooseFilesFromDeviceButton.layer.borderWidth = 3.0
        submitButton.layer.borderWidth = 3.0
        
        writeTextView.text = ""
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
