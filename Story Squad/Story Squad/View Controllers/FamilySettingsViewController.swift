//
//  FamilySettingsViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import ScalingCarousel
import CoreData

class FamilySettingsViewController: UIViewController {
    
    // MARK: - Properties
    var networkingController: NetworkingController?
    var parentUser: Parent?
    
    
    // MARK: - Outlets
    @IBOutlet weak var carousel: ScalingCarouselView!
    
    @IBOutlet weak var enterNewEmailTextField: UITextField!
    @IBOutlet weak var enterOldPasswordTextField: UITextField!
    @IBOutlet weak var enterNewPasswordTextField: UITextField!
    @IBOutlet weak var reEnterNewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromSignup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        carousel.reloadData()
    }
    
    // To receive the Parent and NetworkingController from the Tab Bar
    func receiveDataFromSignup() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.parentUser = tabBar.parentUser
        self.networkingController = tabBar.networkingController
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        carousel.deviceRotated()
    }
    
    @IBAction func addChildButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        showCompleteAlert()
    }
    
// MARK: - Alert for Update Complete
    func showCompleteAlert() {
        let alert = UIAlertController(title: "Family Settings", message: "Update Complete", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


extension FamilySettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "childCollectionViewCell", for: indexPath)

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

