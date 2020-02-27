//
//  DashboardViewController.swift
//  Story Squad
//
//  Created by macbook on 2/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
   
// MARK: - Properties
    
    var parentUser: Parent?
    var childrenArray: [Child]?
    
    @IBOutlet weak var storySquadLabel: UILabel!
    @IBOutlet weak var childrenProfilesCollectionView: UICollectionView!
    
    @IBOutlet weak var hamburgerMenuButton: UIBarButtonItem!
    @IBOutlet weak var addChildButton: UIButton!
    
    let transition = SlideInTransition()
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
        .strokeWidth: -3.5
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func hamburgerMenuTapped(_ sender: UIBarButtonItem) {
        
        guard let hamburgerMenuVC = storyboard?.instantiateViewController(identifier: "HamburgerMenuViewController") as? HamburgerMenuTableViewController else { return }
        
        hamburgerMenuVC.menuOptionTapped = { menueOption in
            self.transitionTo(menueOption)
        }
        hamburgerMenuVC.modalPresentationStyle = .overCurrentContext
        hamburgerMenuVC.transitioningDelegate = self
        present(hamburgerMenuVC, animated: true)
    }
    
    func transitionTo(_ menueOption: HamburgerMenuOptions) {
        
        switch menueOption {
            
        case .parentAccount:
            let parentAccountMainStoryboard = UIStoryboard(name: "SettingsParentPin", bundle: nil)
            let parentSettingsPinVC = parentAccountMainStoryboard.instantiateViewController(withIdentifier: "SettingsParentPinSB")
            self.navigationController!.pushViewController(parentSettingsPinVC, animated: true)
    
        case .help:
            let helpStoryboard = UIStoryboard(name: "Help", bundle: nil)
            let helpVC = helpStoryboard.instantiateViewController(withIdentifier: "HelpVC")
            self.navigationController!.pushViewController(helpVC, animated: true)
            
        case .logout:
            // TODO: Alert to confirm logout
            print("alert to logout")
        }
    }
    
    func updateViews() {
        
        let pumkinStrokeAttribute = NSAttributedString(string: storySquadLabel.text!, attributes: sqLabelStrokeAttributes)
        
        storySquadLabel.attributedText = pumkinStrokeAttribute
        storySquadLabel.textColor = UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1)
        
        childrenProfilesCollectionView.delegate = self
        childrenProfilesCollectionView.dataSource = self
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

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10 // Change
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = childrenProfilesCollectionView.dequeueReusableCell(withReuseIdentifier: "ChildProfileCell", for: indexPath)
        
        return cell
    }
}

extension DashboardViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
