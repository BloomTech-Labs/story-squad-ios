//
//  ManageSubscriptionViewController.swift
//  Story Squad
//
//  Created by Lambda_School_Loaner_263 on 3/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class ManageSubscriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
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
        fetchResultsController.delegate = self as! NSFetchedResultsControllerDelegate
        
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
          // carousel.reloadData()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childCollectionView.register(UINib.init(nibName: "ChildCollectionViewCell.xib", bundle: nil), forCellWithReuseIdentifier: "childCollectionViewCellIdentifier")
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: childCollectionView.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        childCollectionView.collectionViewLayout = flowLayout
        
        childCollectionView.delegate = self
        childCollectionView.dataSource = self
    }
    
    // MARK: - UICollectionView Delegates and DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return children.count
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "childCollectionViewCellIdentifier", for: indexPath) as! ChildCollectionViewCell
        
        //cell.avatarImageView.image = child?.avatar
        cell.nameLabel.text = child?.name
        return cell
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

