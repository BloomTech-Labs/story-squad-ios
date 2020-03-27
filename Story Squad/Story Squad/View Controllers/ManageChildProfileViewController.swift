//
//  ManageChildProfileViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class ManageChildProfilesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var child: Child?
    
    var fetchResultsController: NSFetchedResultsController<Child> {
        
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        
        // Fetch for Children of correct Parent
        let predicate = NSPredicate(format: "parent.id == %i", parentUser?.id ?? 0)
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
    
    @IBOutlet weak var childCollectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        childCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //updateViews()
        receiveDataFromSignup()
        setupChildCollectionView()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        handleSignOut()
    }
    
    // Setup ChildCollectionView's Properties
    private func setupChildCollectionView() {
        childCollectionView.register(UINib.init(nibName: "ChildCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "childCollectionViewCellIdentifier")
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 200.0, height: childCollectionView.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 0.3
        flowLayout.spacingMode = .fixed(spacing: 40.0)
        childCollectionView.collectionViewLayout = flowLayout
        
        childCollectionView.delegate = self
        childCollectionView.dataSource = self
    }
    
    // To receive the Parent and NetworkingController from the Tab Bar
    func receiveDataFromSignup() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.parentUser = tabBar.parentUser
        self.networkingController = tabBar.networkingController
    }
    
    func handleSignOut() {
        
        networkingController?.logOut()
        dismiss(animated: true, completion: nil)
    }
    
    private func updateViews() {
    }
    
    // MARK: - UICollectionView Delegates and DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return children.count
        //        5
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "childCollectionViewCellIdentifier", for: indexPath) as! ChildCollectionViewCell
        
        let child = fetchResultsController.object(at: indexPath)
        let avatar = child.avatar
        
        cell.avatarImageView.image = UIImage(named: avatar ?? "Hero 12.png")
        //cell.nameLabel.text = child.name
        
        if let username = child.username {
                   cell.nameLabel.text = username
               } else {
                   cell.nameLabel.text = child.name
               }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ChildSettingsFromManageProfilesSegue", sender: self)
        print("child selected == \(indexPath.row)")
        print("child name == \(child?.name ?? "no name")")
    }
      
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ChildSettingsFromManageProfilesSegue" {
            
            if let indexPath = childCollectionView.indexPathsForSelectedItems?.first,
                let childSettingsVC = segue.destination as? ChildSettingsViewController {
                
               let child = fetchResultsController.object(at: indexPath)
                childSettingsVC.childUser = child
                childSettingsVC.parentUser = parentUser
                childSettingsVC.networkingController = networkingController
            }
        } else if segue.identifier == "toAddChildSegue" {
            if let addChildVC = segue.destination as? AddChildViewController {
                
                addChildVC.parentUser = parentUser
                addChildVC.networkingController = networkingController
            }
        }
    }
}
