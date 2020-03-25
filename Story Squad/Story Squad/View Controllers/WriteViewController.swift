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
        submitStory()
    }
    
    @IBAction func chooseFilesFromDeviceButtonTapped(_ sender: UIButton) {
    }
    
    private func submitStory() {
        
       // TODO: Check that at least you have one image or that the written story is not empty before attempting to submit the Story
        
        if let child = childUser,
            let writtenStory = writeTextView.text,
            !writtenStory.isEmpty {
            
            networkingController?.submitStory(child: child, storyText: writtenStory, page1: nil, page2: nil, page3: nil, page4: nil, page5: nil, completion: { (result) in
                
                do {
                    //swiftlint:disable:next redundant_discardable_let
                    let _ = try result.get()
                    
                    DispatchQueue.main.async {
                        self.showStorySubmittedAlert()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showErrorAlert(errorTitle: "Couldn't save your Story", errorMessage: " You can only submit one Story for this week. If you haven't submitted one yet, please try again")
                    }
                }
            })
        } else {
            showErrorAlert(errorTitle: "No Story found", errorMessage: "Please write your story before submitting")
        }
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
