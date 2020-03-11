//
//  ManageSubscriptionViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ManageSubscriptionViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    @IBOutlet weak var comingSoonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comingSoonLabel.transform = CGAffineTransform.init(rotationAngle: 0.75)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelSubscriptionButtonTapped(_ sender: Any) {
        showCancelSubscriptionAlert()
    }
    
    // MARK: - Alert for Update Complete
    func showCancelSubscriptionAlert() {
        let alert = UIAlertController(title: "Cancel Subscription", message: "Cancelling subscription will prevent you from accessing member content.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep Subscription", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel Subscription", style: .destructive, handler: nil))
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
