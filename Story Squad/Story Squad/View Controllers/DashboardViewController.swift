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
    
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
        .strokeWidth: -3.5
    ]
    
    var fetchResultsController: NSFetchedResultsController<Child> {
        
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        
        // Fetch for Children of correct Parent
        let predicate = NSPredicate(format: "parent.id == %@", getParentID())
        fetchRequest.predicate = predicate
        
        // Sort Children by Name
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        
        // Try to perform Fetch
        do {
            try fetchResultsController.performFetch() // fail
        } catch {
            fatalError("Failed to fetch child entities: \(error)")
        }
        return fetchResultsController
    }
    
    // MARK: - Outlets
    @IBOutlet weak var storySquadLabel: UILabel!
    @IBOutlet weak var childrenProfilesCollectionView: UICollectionView!
    @IBOutlet weak var addChildButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        receiveDataFromSignup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        childrenProfilesCollectionView.reloadData()
    }
    
    // To receive the Parent and NetworkingController from the Tab Bar
    func receiveDataFromSignup() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.parentUser = tabBar.parentUser
        self.networkingController = tabBar.networkingController
    }
    
    // Get Parent's id as a string to fetch Children from CoreData
    private func getParentID() -> String {
        guard let parent = parentUser,
            let id = parent.id else { return ""}
        
        return id
    }
    
    private func updateViews() {
        
        let pumkinStrokeAttribute = NSAttributedString(string: storySquadLabel.text!, attributes: sqLabelStrokeAttributes)
        
        storySquadLabel.attributedText = pumkinStrokeAttribute
        storySquadLabel.textColor = UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1)
        
        //        addChildButton.layer.cornerRadius = 10
        
        // Setup the Children Profiles Collection View
        childrenProfilesCollectionView.delegate = self
        childrenProfilesCollectionView.dataSource = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass data to AddChildVc
        if segue.identifier == "AddChildSegue" {
            guard let addChildVC = segue.destination as? AddChildViewController  else { return }
            addChildVC.parentUser = self.parentUser
            addChildVC.networkingController = self.networkingController
            
            // Ask for Child PIN to display Child's Profile
     //   } else if segue.identifier == "ShowChildPinVCSegue" {
//            guard let childProfilePinVC = segue.destination as? ChildProfilePinViewController else { return }
            
          //  if let sender = sender as? ChildProfileCollectionViewCell {
            //    guard let indexPath = childrenProfilesCollectionView.indexPath(for: sender) else { return }
                
//                childProfilePinVC.parentUser = self.parentUser
//                childProfilePinVC.childUser = fetchResultsController.object(at: indexPath)
//                childProfilePinVC.networkingController = self.networkingController
            
        }
    }
}

// MARK: - Fetching Children from CD
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //swiftlint:disable force_cast
        let cell = childrenProfilesCollectionView.dequeueReusableCell(withReuseIdentifier: "ChildProfileCell", for: indexPath) as! ChildProfileCollectionViewCell
        
        let child = fetchResultsController.object(at: indexPath)
        cell.childUser = child
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //performSegue(withIdentifier: "ChildProfileFromDashboardSegue", sender: self)
    }
}
