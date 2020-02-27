//
//  AddChildViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AddChildViewController: UIViewController {
    
    // MARK: - Outlets
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childAdded: Child?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
