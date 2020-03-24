//
//  ChildSettingsViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildSettingsViewController: UIViewController {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?
    
    var childName: String?
    let gradePicker = UIPickerView()
    var arrayOfGrades = ["Select Grade", "3rd Grade", "4th Grade", "5th Grade", "6th Grade"]
    var grade: Int16?
    
    var initialDyslexiaSliderState: Bool?
    var initialGrade: SchoolGrade?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var currentNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var gradeTextField: GradeTextField!
    
    @IBOutlet weak var currentPinTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    @IBOutlet weak var dyslexiaSlider: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPicker()
        createToolbar()
        updateViews()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func dyslexiaSliderToggled(_ sender: UISwitch) {
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        guard let child = childUser else { return }
        
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            showErrorAlert(errorTitle: "No changes made", errorMessage: errorMessage!)
        } else {
            
            let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//            let pin = pinTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

            let dyslexiaBool = dyslexiaSlider.isOn
            
            // Check Child's Grade
            switch gradeTextField.text {
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
                
                networkingController?.updateChildAccountInServer(child: child, username: name, dyslexiaPreference: dyslexiaBool, grade: grade, completion: { (result) in
                    
                    do {
                        let child = try result.get()
                        
                        DispatchQueue.main.async {
                            
                            self.childUser = child
                            self.showCompleteAlert()
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.showErrorAlert(errorTitle: "Something went wrong", errorMessage: "Please check you changes and try again")
                        }
                    }
                })
            } else {
                showErrorAlert(errorTitle: "", errorMessage: "")
                return
            }
        }
    }
    
    private func validateFields() -> String? {
        
        // Check that at least one change was made
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            pinTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            initialDyslexiaSliderState == dyslexiaSlider.isOn &&
            initialGrade?.rawValue == gradeTextField.text {
            
            return "Please make at least one change to update Child Account"
        }
        return nil
    }
    
    private func showErrorAlert(errorTitle: String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Alert for Update Complete
    private func showCompleteAlert() {
        let alert = UIAlertController(title: "Success!", message: "Child Account has been updated", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func updateViews() {
        
        guard let childUser = childUser,
            let name = childUser.name else { return }
        
        let pinString = String(childUser.pin)
        
        // Pupolate the grade TextField with the Child's Grade
        switch childUser.grade {
        case 3:
            gradeTextField.text = SchoolGrade.thirdGrade.rawValue
            initialGrade = SchoolGrade.thirdGrade
        case 4:
            gradeTextField.text = SchoolGrade.forthGrade.rawValue
            initialGrade = SchoolGrade.forthGrade
        case 5:
            gradeTextField.text = SchoolGrade.fifthGrade.rawValue
            initialGrade = SchoolGrade.fifthGrade
        case 6:
            gradeTextField.text = SchoolGrade.sixthGrade.rawValue
            initialGrade = SchoolGrade.sixthGrade
        default:
            grade = nil
        }
        
        nameLabel.text = name
        currentNameTextField.text = "\(name)"
        currentPinTextField.text = "\(pinString)"
        
        // Capture the state of the initial state of the dyslexia switch
        initialDyslexiaSliderState = dyslexiaSlider.isOn
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
extension ChildSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func createPicker() {
        let gradePicker = UIPickerView()
        gradePicker.delegate = self
        gradePicker.delegate?.pickerView?(gradePicker, didSelectRow: 0, inComponent: 0)
        gradeTextField.inputView = gradePicker
        gradeTextField.isUserInteractionEnabled = true
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

