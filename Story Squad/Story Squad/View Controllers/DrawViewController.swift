//
//  DrawViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    var imagePicker: ImagePicker!
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chooseFilesFromDeviceButton: UIButton!
    
    @IBOutlet weak var selectedImage1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
    }
    
    @IBAction func chooseFilesFromDeviceButton(_ sender: Any) {
    }
    
    func updateViews() {
       promptLabel.layer.borderWidth = 7.0
        promptLabel.layer.cornerRadius = 10.0
        chooseFilesFromDeviceButton.layer.borderWidth = 3.0
        chooseFilesFromDeviceButton.layer.cornerRadius = 10.0
               submitButton.layer.borderWidth = 3.0
        submitButton.layer.cornerRadius = 10
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

extension DrawViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        let imageString = image?.description
        selectedImage1Label.text = imageString
    }
}
