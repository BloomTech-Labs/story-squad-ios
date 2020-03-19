//
//  ReadPageViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//
import Foundation
import UIKit

class ReadPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.pageContentViewController(page: "Page0"),
                self.pageContentViewController(page: "Page1"),
                self.pageContentViewController(page: "Page2")]
    }()

    private func pageContentViewController(page: String) -> UIViewController {
        return UIStoryboard(name: "Read", bundle: nil) .
            instantiateViewController(withIdentifier: "\(page)ViewController")
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

extension ReadPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        return getViewControllerAtIndex(index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
     viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
             return nil
         }
         
         let previousIndex = viewControllerIndex - 1
         
         guard previousIndex >= 0 else {
             return nil
         }
         
         guard orderedViewControllers.count > previousIndex else {
             return nil
         }
         
         return orderedViewControllers[previousIndex]
 }

    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
             return nil
         }
         
         let nextIndex = viewControllerIndex + 1
         let orderedViewControllersCount = orderedViewControllers.count

         guard orderedViewControllersCount != nextIndex else {
             return nil
         }
         
         guard orderedViewControllersCount > nextIndex else {
             return nil
         }
         
         return orderedViewControllers[nextIndex]
 }

    private func pageViewController(pageViewController: ReadPageViewController, willTransitionTo: [UIViewController]) {

    }
    // Called before a gesture-driven transition begins.

    private func pageViewController(pageViewController: ReadPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {

    }
     // Called after a gesture-driven transition completes.
    
    private func pageViewController(pageViewController: ReadPageViewController, spineLocationFor: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        return .min
    }
     // Returns the spine location for the given orientation.
}
