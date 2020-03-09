//
//  ManageSubscriptionViewController.swift
//  Story Squad
//
//  Created by Lambda_School_Loaner_263 on 3/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import ScalingCarousel
import CoreData

class Cell: ScalingCarouselCell {}

class ManageSubscriptionViewController: UIViewController {
 
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    
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
     @IBOutlet weak var carousel: ScalingCarouselView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           carousel.reloadData()
       }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        carousel.deviceRotated()
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

extension ManageSubscriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 10
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "childCollectionViewCell", for: indexPath)

        // FOR JONALYNN!! This is the correct child that you need, but not sure how you want to use this.
        let child = fetchResultsController.object(at: indexPath)
        
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        carousel.didScroll()
        
       // guard let currentCenterIndex = carousel.currentCenterCellIndex?.row else { return }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

//typealias CarouselDelegate = FamilySettingsViewController
//extension FamilySettingsViewController: UICollectionViewDelegate {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        carousel.didScroll()
//
//       // guard let currentCenterIndex = carousel.currentCenterCellIndex?.row else { return }
//    }
//}
//
//private typealias ScalingCarouselFlowDelegate = FamilySettingsViewController
//extension ScalingCarouselFlowDelegate: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 0
//    }
//}
