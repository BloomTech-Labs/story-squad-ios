//
//  CreditCardViewController.swift
//  Story Squad
//
//  Created by macbook on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expirationTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addCardButtonPressed(_ sender: UIButton) {
        
        guard let cardNumber = cardNumberTextField.text,
            let name = nameTextField.text,
            let exp = expirationTextField.text,
            let cvc = cvcTextField.text,
            let zipCode = zipcodeTextField.text,
            !cardNumber.isEmpty,
            !name.isEmpty,
            !exp.isEmpty,
            !cvc.isEmpty,
            !zipCode.isEmpty else { return }
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
