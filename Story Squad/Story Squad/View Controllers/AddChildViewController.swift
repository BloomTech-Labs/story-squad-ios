//
//  AddChildViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AddChildViewController: UIViewController {
    
    // MARK: - Properties
    
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childAdded: Child?
    
    let gradePicker = UIPickerView()
    var arrayOfGrades = ["Select Grade", "3rd Grade", "4th Grade", "5th Grade", "6th Grade"]
    var grade: Int16?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPicker()
        createToolbar()
    }
    
    @IBAction func dyslexiaToggleSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        // Check all Text Fields are filled
        guard let parent = parentUser,
            let name = nameTextField.text,
            let pin = pinTextField.text,
            !name.isEmpty,
            !pin.isEmpty,
            let pinInt = Int16(pin) else { return }
        
        // Check Child's Grade
        switch gradeLabel.text {
        case SchoolGrade.thirdGrade.rawValue:
            grade = 3
        case SchoolGrade.forthGrade.rawValue:
            grade = 4
        case SchoolGrade.fifthGrade.rawValue:
            grade = 5
        case SchoolGrade.sixthGrade.rawValue:
            grade = 6
        default:
            grade = nil
        }
        
        // Continue if grade is not nil
        if let grade = grade {
            
            networkingController?.createChildAndAddToParent(parent: parent, name: name, username: nil, pin: pinInt, grade: grade, cohort: nil, avatar: nil, context: CoreDataStack.shared.mainContext)
            
            // Go back to Dashboard
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            showIncompleteAlert()
        }
    }
    
    // MARK: - Incomplete Child Data Alert
    func showIncompleteAlert() {
        let alert = UIAlertController(title: "Incomplete Child Information", message: "Please fill in all Text Fields", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
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

// MARK: - Grade Picker
extension AddChildViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        
        func createPicker() {
        let gradePicker = UIPickerView()
        gradePicker.delegate = self
        gradePicker.delegate?.pickerView?(gradePicker, didSelectRow: 0, inComponent: 0)
//        gradeTextField.inputView = gradePicker
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(gestureRecognizer:)))
            gradeLabel.addGestureRecognizer(tapGesture)
            gradeLabel.isUserInteractionEnabled = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfGrades.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfGrades[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return gradeLabel.text =  arrayOfGrades[row]
    }
    
    @objc func tap(gestureRecognizer: UITapGestureRecognizer) {
        print("*")
        gradePicker.isHidden = false
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddChildViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
//        gradeTextField.inputAccessoryView = toolbar
    }
    
    @objc func closePickerView() {
        view.endEditing(true)
    }
}
