//
//  ManageSubscriptionViewController.swift
//  Story Squad
//
//  Created by Lambda_School_Loaner_263 on 3/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class ManageSubscriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var child: Child?
    
    var fetchResultsController: NSFetchedResultsController<Child> {
        
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        
        // Fetch for Children of correct Parent
        let predicate = NSPredicate(format: "parent.id == %d", parentUser?.id ?? 0)
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
    @IBOutlet weak var cancelSubscriptionButton: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        childCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childCollectionView.register(UINib.init(nibName: "ChildCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "childCollectionViewCellIdentifier")
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 100.0, height: childCollectionView.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 10.0)
        childCollectionView.collectionViewLayout = flowLayout
        
        childCollectionView.delegate = self
        childCollectionView.dataSource = self
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
        
        if let avatar = child.avatar {
            let avatarImage = UIImage(data: avatar)
            cell.avatarImageView.image = avatarImage
        }
        
        cell.nameLabel.text = child.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("child selected == \(indexPath.row)")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func cancelSubsctiptionButtonTapped(_ sender: UIButton) {
         
        showCancelSubscriptionAlert()
    }
    // MARK: - Alert for Update Complete
    func showCancelSubscriptionAlert() {
        let alert = UIAlertController(title: "Cancel Subscription", message: "Cancelling subscription will prevent you from accessing member content.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep Subscription", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel Subscription", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
}
