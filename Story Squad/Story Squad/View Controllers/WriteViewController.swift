//
//  WriteViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet weak var promptTextView: UITextView!
    
    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    //@IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+200)
        writeTextView.delegate = self
        updateViews()
    }
    
    func updateViews() {
        promptTextView.layer.borderWidth = 7.0
        writeTextView.layer.cornerRadius = 10
        writeTextView.layer.borderWidth = 3.0
        uploadButton.layer.borderWidth = 3.0
        submitButton.layer.borderWidth = 3.0
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

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        writeTextView.text = ""
    }
}
