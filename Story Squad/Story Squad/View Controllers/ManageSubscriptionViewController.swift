//
//  ManageSubscriptionViewController.swift
//  Story Squad
//
//  Created by Lambda_School_Loaner_263 on 3/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ManageSubscriptionViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Adds Google Analytics tracking for this view controller
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: "ManageSubscriptionViewController")

        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
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
