//
//  ChildSettingsViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildSettingsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var pinConfirmationTextField: UITextField!
    @IBOutlet weak var dyslexiaSlider: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           // Adds Google Analytics tracking for this view controller
           guard let tracker = GAI.sharedInstance().defaultTracker else { return }
           tracker.set(kGAIScreenName, value: "ChildSettingsViewController")

           guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
           tracker.send(builder.build() as [NSObject : AnyObject])
       }
    
    @IBAction func dyslexiaSliderToggled(_ sender: UISwitch) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text,
            let pin = pinTextField.text,
            let pinConfirmation = pinConfirmationTextField.text,
            !name.isEmpty,
            !pin.isEmpty,
            !pinConfirmation.isEmpty else { return }
        
        // TODO: save switch state if changed to .isOn
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
