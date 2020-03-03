//
//  DashboardViewController.swift
//  Story Squad
//
//  Created by macbook on 2/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    
    // MARK: - Properties
    
    var networkingController: NetworkingController?
    
    var parentUser: Parent?
    var childrenArray: [Child]?
    var childUser: Child?
    
    let transition = SlideInTransition()
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
        .strokeWidth: -3.5
    ]
    
    var fetchResultsController: NSFetchedResultsController<Child> {
        
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        
        // Fetch for Children of correct Parent
        let predicate = NSPredicate(format: "%K == %@", "parent.name", getParentName())
        fetchRequest.predicate = predicate
        
        // Sort Children by Name
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        
        // Try to perform Fetch
        do {
            try fetchResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch child entities: \(error)")
        }
        return fetchResultsController
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var storySquadLabel: UILabel!
    @IBOutlet weak var childrenProfilesCollectionView: UICollectionView!
    @IBOutlet weak var addChildButton: UIButton!
    @IBOutlet weak var viewChildProfileButton: UIButton!
    @IBOutlet weak var profileCardBlueView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        childrenProfilesCollectionView.reloadData()
    }
    
    // MARK: - Hambuerger Menu
    @IBAction func hamburgerMenuTapped(_ sender: UIBarButtonItem) {
        
        guard let hamburgerMenuVC = storyboard?.instantiateViewController(identifier: "HamburgerMenuViewController") as? HamburgerMenuTableViewController else { return }
        
        hamburgerMenuVC.menuOptionTapped = { menueOption in
            self.transitionTo(menueOption)
        }
        hamburgerMenuVC.modalPresentationStyle = .overCurrentContext
        hamburgerMenuVC.transitioningDelegate = self
        present(hamburgerMenuVC, animated: true)
    }
    
    // Transitioning from Hamburger Menu
    func transitionTo(_ menueOption: HamburgerMenuOptions) {
        
        switch menueOption {
            
        case .parentAccount:
            let parentAccountMainStoryboard = UIStoryboard(name: "SettingsParentPin", bundle: nil)
            
            //swiftlint:disable force_cast
            let parentSettingsPinVC = parentAccountMainStoryboard.instantiateViewController(withIdentifier: "SettingsParentPinSB") as! SettingsParentPinViewController
            
            parentSettingsPinVC.parentUser = self.parentUser
            parentSettingsPinVC.networkingController = self.networkingController
            self.navigationController!.pushViewController(parentSettingsPinVC, animated: true)
            
        case .help:
            let helpStoryboard = UIStoryboard(name: "Help", bundle: nil)
            
            //swiftlint:disable force_cast
            let helpVC = helpStoryboard.instantiateViewController(withIdentifier: "HelpVC") as! HelpViewController
            
            self.navigationController!.pushViewController(helpVC, animated: true)
            
        case .logout:
            // TODO: Alert to confirm logout
            print("alert to logout")
        }
    }
    
    private func updateViews() {
        
        let pumkinStrokeAttribute = NSAttributedString(string: storySquadLabel.text!, attributes: sqLabelStrokeAttributes)
        
        storySquadLabel.attributedText = pumkinStrokeAttribute
        storySquadLabel.textColor = UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1)
        
        profileCardBlueView.layer.cornerRadius = 10
        viewChildProfileButton.layer.cornerRadius = 10
        //        addChildButton.layer.cornerRadius = 10
        
        // Setup the Children Profiles Collection View
        childrenProfilesCollectionView.delegate = self
        childrenProfilesCollectionView.dataSource = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Ask for Parent PIN for adding a new Child
        if segue.identifier == "AddChildSegueToPin" {
            guard let addChildSegueToPinVC = segue.destination as? AddChildParentPinViewController  else { return }
            addChildSegueToPinVC.parentUser = self.parentUser
            addChildSegueToPinVC.networkingController = self.networkingController
            
            // Ask for Child PIN to display Child's Profile
        } else if segue.identifier == "ShowChildPinVCSegue" {
            guard let childProfilePinVC = segue.destination as? ChildProfilePinViewController else { return }
            
            if let sender = sender as? ChildProfileCollectionViewCell {
                guard let indexPath = childrenProfilesCollectionView.indexPath(for: sender) else { return }
                
                childProfilePinVC.parentUser = self.parentUser
                childProfilePinVC.childUser = fetchResultsController.object(at: indexPath)
                childProfilePinVC.networkingController = self.networkingController
            }
        }
    }
}

// MARK: - Fetching Children from CD
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    // Get Parent's name as a String
    private func getParentName() -> String {
        guard let parent = parentUser,
            let name = parent.name else { return ""}
        
        return name
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = childrenProfilesCollectionView.dequeueReusableCell(withReuseIdentifier: "ChildProfileCell", for: indexPath) as! ChildProfileCollectionViewCell
        
        let child = fetchResultsController.object(at: indexPath)
        cell.childUser = child
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - Preparing for Transition from HB Menu
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
