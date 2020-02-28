//
//  SettingsParentPinViewController.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SettingsParentPinViewController: UIViewController {
   
    // MARK: - Properties
    
    var networkingController: NetworkingController?
    var parentUser: Parent?
    
    // MARK: - Outlets
    
    @IBOutlet weak var digitBox1TextField: UITextField!
    @IBOutlet weak var digitBox2TextField: UITextField!
    @IBOutlet weak var digitBox3TextField: UITextField!
    @IBOutlet weak var digitBox4TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        
        guard let digit1 = digitBox1TextField.text,
            let digit2 = digitBox2TextField.text,
            let digit3 = digitBox3TextField.text,
            let digit4 = digitBox4TextField.text,
            !digit1.isEmpty,
            !digit2.isEmpty,
            !digit3.isEmpty,
            !digit4.isEmpty else { return }
        
        let pinString = "\(digit1)\(digit2)\(digit3)\(digit4)"
        let pinInt = Int16(pinString)
        
        guard let parent = parentUser else { return }
        
        if pinInt == parent.pin {
            let parentAccountMainSB = UIStoryboard(name: "ParentAccountMainVC", bundle: nil)

			//swiftlint:disable force_cast
			let parentAccountMainVC = parentAccountMainSB.instantiateViewController(withIdentifier: "ParentAccountVC") as! ParentAccountMainVC
            
            parentAccountMainVC.parentUser = self.parentUser
            parentAccountMainVC.networkingController = self.networkingController
            self.navigationController!.pushViewController(parentAccountMainVC, animated: true)
        } else {
            showWrongPinAlert()
        }
    }
    
    func showWrongPinAlert() {
        let alert = UIAlertController(title: "Incorrect PIN", message: "Pin entered does not match our records", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /*
     
    // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ParentAccountMainVCSegue" {
            guard let ParentAccountMainVC = segue.destination as? ParentAccountMainVC else { return }
            ParentAccountMainVC.parentUser = self.parentUser
            ParentAccountMainVC.networkingController = self.networkingController
        }
    }
     */
}
