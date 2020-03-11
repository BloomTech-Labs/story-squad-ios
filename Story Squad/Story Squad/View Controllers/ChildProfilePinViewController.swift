//
//  ChildProfilePinViewController.swift
//  Story Squad
//
//  Created by macbook on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

//class ChildProfilePinViewController: UIViewController {
//    
//    // MARK: - Properties
//    
//    var networkingController: NetworkingController?
//    var parentUser: Parent?
//    var childUser: Child?
//    
//    // MARK: - Outlets
//    
//    @IBOutlet weak var digitBox1TextField: UITextField!
//    @IBOutlet weak var digitBox2TextField: UITextField!
//    @IBOutlet weak var digitBox3TextField: UITextField!
//    @IBOutlet weak var digitBox4TextField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    // MARK: - OK Button
//    @IBAction func okButtonPressed(_ sender: UIButton) {
//        
//        // Check all Text Fields are filled
//        guard let digit1 = digitBox1TextField.text,
//            let digit2 = digitBox2TextField.text,
//            let digit3 = digitBox3TextField.text,
//            let digit4 = digitBox4TextField.text,
//            !digit1.isEmpty,
//            !digit2.isEmpty,
//            !digit3.isEmpty,
//            !digit4.isEmpty else { return }
//        
//        let pinString = "\(digit1)\(digit2)\(digit3)\(digit4)"
//        let pinInt = Int16(pinString)
//        
//        guard let child = childUser else { return }
//        
//        // Check if correct Child's PIN
//        if pinInt == child.pin {
//            
//            let childProfileMainSB = UIStoryboard(name: "ChildProfileMainVC", bundle: nil)
//            //swiftlint:disable:next force_cast
//            let childProfileMainVC = childProfileMainSB.instantiateViewController(withIdentifier: "ChildProfileVC") as! ChildProfileMainVC // swiftlint:disable:this superfluous_disable_command
//            
//            // Pass Parent, Child and NetworkingController to Child's ProfileVC
//            childProfileMainVC.networkingController = self.networkingController
//            childProfileMainVC.parentUser = self.parentUser
//            childProfileMainVC.childUser = self.childUser
//            
//            // Go to Child's ProfileVC
//            self.navigationController!.pushViewController(childProfileMainVC, animated: true)
//        } else {
//            showIncorrectPinAlert()
//        }
//    }
//    
//    // MARK: - Incorrect PIN Alert
//    private func showIncorrectPinAlert() {
//        let alert = UIAlertController(title: "Incorrect PIN", message: "Please try again or ask Parent to change PIN in Parent Settings", preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
//        self.present(alert, animated: true)
//    }
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//}
