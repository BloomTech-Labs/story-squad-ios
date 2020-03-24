//
//  ChildSettingsTabViewController.swift
//  Story Squad
//
//  Created by macbook on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChildSettingsTabViewController: UIViewController {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromTabBar()
        updateViews()
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        handleSignOut()
    }
    
    // Sign out
    private func handleSignOut() {
        
        networkingController?.logOut()
        dismiss(animated: true, completion: nil)
    }
    
    // To receive the Child, Parent and NetworkingController from the Tab Bar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? ChildTabBarController else { return }
        
        self.parentUser = tabBar.parentUser
        self.childUser = tabBar.childUser
        self.networkingController = tabBar.networkingController
    }
    
    private func updateViews() {
        
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
