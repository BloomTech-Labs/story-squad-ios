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
        
        updateParentInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func updateParentInfo() {
        
        guard let parentUser = parentUser else { return }
        
        networkingController?.updateParentWithServer(parent: parentUser, completion: { (result) in
            do {
                let parent = try result.get()
                self.parentUser = parent
                print("\nUpdated Parent with Server")
                
            } catch {
                NSLog("Couldn't update Parent with Server")
            }
        })
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
