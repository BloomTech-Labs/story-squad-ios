//
//  FamilySettingsViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import ScalingCarousel

class Cell: ScalingCarouselCell {}

class FamilySettingsViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var carousel: ScalingCarouselView!
    @IBOutlet weak var enterNewEmailTextField: UITextField!
    
    @IBOutlet weak var enterOldPasswordTextField: UITextField!
   
    @IBOutlet weak var enterNewPasswordTextField: UITextField!
    
    @IBOutlet weak var reEnterNewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        carousel.deviceRotated()
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

typealias CarouselDatasource = FamilySettingsViewController
extension CarouselDatasource: UICollectionViewDataSource {
    
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
}


typealias CarouselDelegate = FamilySettingsViewController
extension FamilySettingsViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        carousel.didScroll()
        
       // guard let currentCenterIndex = carousel.currentCenterCellIndex?.row else { return }
    }
}

private typealias ScalingCarouselFlowDelegate = FamilySettingsViewController
extension ScalingCarouselFlowDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}
