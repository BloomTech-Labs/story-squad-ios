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
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPicker()
        createToolbar()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        guard let name = nameTextField.text,
            !name.isEmpty,
            let grade = gradeTextField.text,
            !grade.isEmpty,
            let pin = pinTextField.text,
            !pin.isEmpty,
            let parent = parentUser,
            let pinInt = Int16(pin),
            let gradeInt = Int16(grade) else { return }
        
        networkingController?.createChildAndAddToParent(parent: parent, name: name, username: nil, pin: pinInt, grade: gradeInt, cohort: nil, avatar: nil, context: CoreDataStack.shared.mainContext)
        
        self.navigationController?.popToRootViewController(animated: true)
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

extension AddChildViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        
        func createPicker() {
        let gradePicker = UIPickerView()
        gradePicker.delegate = self
        gradePicker.delegate?.pickerView?(gradePicker, didSelectRow: 0, inComponent: 0)
        gradeTextField.inputView = gradePicker
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
        return gradeTextField.text =  arrayOfGrades[row]
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddChildViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        gradeTextField.inputAccessoryView = toolbar
    }
    
    @objc func closePickerView() {
        view.endEditing(true)
    }
}
