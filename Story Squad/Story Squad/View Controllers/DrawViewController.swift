//
//  DrawViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?
    
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chooseFilesFromDeviceButton: UIButton!
    
    @IBOutlet weak var selectedImage1Label: UILabel!
    @IBOutlet weak var selectAnImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitDrawing()
    }
        
    @IBAction func chooseFilesFromDeviceButtonTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    func updateViews() {
        promptLabel.layer.borderWidth = 7.0
        promptLabel.layer.cornerRadius = 10.0
        chooseFilesFromDeviceButton.layer.borderWidth = 3.0
        chooseFilesFromDeviceButton.layer.cornerRadius = 10.0
        submitButton.layer.borderWidth = 3.0
        submitButton.layer.cornerRadius = 10
    }
    
    func showDrawingSubmittedAlert() {
        
        let alert = UIAlertController(title: "Your Amazing Drawing has been Submitted!", message: "Thank you", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(errorTitle: String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func submitDrawing() {
        if let drawing = selectedImage1Label.text,
            !drawing.isEmpty {
            //
            //                   networkingController?.submitDrawing(child: Child, drawingImage: <#T##String#>, completion: <#T##(Result<String?, NetworkingError>) -> Void#>)
            //
            //                       do {
            //                           //swiftlint:disable:next redundant_discardable_let
            //                           let _ = try result.get()
            //
            //                           DispatchQueue.main.async {
            //                               self.showStorySubmittedAlert()
            //                           }
            //                       } catch {
            //                           DispatchQueue.main.async {
            //                               self.showErrorAlert(errorTitle: "Couldn't save your Story", errorMessage: " You can only submit one Story for this week. If you haven't submitted one yet, please try again")
            //                           }
            //                       }
            //                })
            showDrawingSubmittedAlert()
        } else {
            showErrorAlert(errorTitle: "No Drawing found", errorMessage: "Please upload an image before submitting")
            //               }
            //           }
            //    }
        }
    }
}
extension DrawViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        let imageString = image?.description
        selectedImage1Label.text = imageString
    }
}
