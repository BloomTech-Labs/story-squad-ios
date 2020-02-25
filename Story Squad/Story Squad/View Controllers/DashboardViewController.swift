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
    @IBOutlet weak var storySquadLabel: UILabel!
    @IBOutlet weak var childrenProfilesCollectionView: UICollectionView!
    @IBOutlet weak var hamburgerMenuButton: UIBarButtonItem!

    @IBOutlet weak var addChildButton: UIButton!
    
    let sqLabelStrokeAttributes: [NSAttributedString.Key: Any] = [
//        .foregroundColor: UIColor(red: 0, green: 0.477, blue: 0.733, alpha: 1),
//        .font: UIFont(name: "Avenir", size: 100)!,
        .strokeColor: UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1),
        .strokeWidth: -3.5
    ]
    
    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func hamburgerMenuTapped(_ sender: UIBarButtonItem) {
        guard let hamburgerMenuVC = storyboard?.instantiateViewController(identifier: "HamburgerMenuViewController") else { return }
        
        hamburgerMenuVC.modalPresentationStyle = .overCurrentContext
        hamburgerMenuVC.transitioningDelegate = self
        present(hamburgerMenuVC, animated: true)
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
