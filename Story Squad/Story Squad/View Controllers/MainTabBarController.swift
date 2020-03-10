//
//  MainTabBarController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var networkingController: NetworkingController? 
    var parentUser: Parent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Adds Google Analytics tracking for this view controller
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: "MainTabBarController")

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
