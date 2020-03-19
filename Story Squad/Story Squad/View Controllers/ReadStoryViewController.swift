//
//  PageContentViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    case pageFour
    case pageFive
    case pageSix
    case pageSeven
    case pageEight
    case pageNine
    case pageTen
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        case .pageFour:
            return 4
        case .pageFive:
            return 5
        case .pageSix:
            return 6
        case .pageSeven:
            return 7
        case .pageEight:
            return 8
        case .pageNine:
            return 9
        case .pageTen:
            return 10
        }
    }

class ReadStoryViewController: UIViewController {
    
    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPageController()
    }
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC = PagesContentVC(with: pages[0])
        
        self.pageController?.setViewControllers([initialVC],
                                                direction: .forward,
                                                animated: true,
                                                completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
}

extension ReadStoryViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PagesContentVC else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: PagesContentVC = PagesContentVC(with: pages[index])
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PagesContentVC else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        let vc: PagesContentVC = PagesContentVC(with: pages[index])
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}