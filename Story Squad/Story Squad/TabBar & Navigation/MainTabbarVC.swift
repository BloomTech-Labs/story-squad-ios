//
//  MainTabbarVC.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/15/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      UITabBar.appearance().tintColor = .white
      
      let tabbarColor = UITabBarAppearance()
      tabbarColor.configureWithOpaqueBackground()
      tabbarColor.backgroundColor = UIColor.tabbarColor
      tabBar.standardAppearance = tabbarColor
      
      
      UINavigationBar.appearance().tintColor = .white
      let coloredAppearance = UINavigationBarAppearance()
      coloredAppearance.configureWithOpaqueBackground()
      coloredAppearance.backgroundColor = UIColor.navigationColor
      coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
             
      UINavigationBar.appearance().standardAppearance = coloredAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      

        createTabbar()
    }//
    
   
   func createTabbar() {
      let tabbar = [createMissionNC(), createLeaderboardNC(), createGalleryNC(), createSettingNC()]
      viewControllers = tabbar
   }//

   
   func createMissionNC() -> UINavigationController {
      let missionVC = MissionVC()
      missionVC.tabBarItem.image = UIImage(systemName: "star")
      missionVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
      missionVC.tabBarItem.title = "Mission"
      
  //    missionVC.navigationController?.navigationBar.backgroundColor = .white
      
      return UINavigationController(rootViewController: missionVC)
   }//
   
   func createLeaderboardNC() -> UINavigationController {
      let leaderboardVC = LeaderboardVC()
      leaderboardVC.tabBarItem.image = UIImage(systemName: "pencil.circle")
      leaderboardVC.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
      leaderboardVC.tabBarItem.title = "Leaderboard"
      
      return UINavigationController(rootViewController: leaderboardVC)
   }//
   
   func createGalleryNC() -> UINavigationController {
      let galleryVC = GalleryVC()
      galleryVC.tabBarItem.image = UIImage(systemName: "tablecells")
      galleryVC.tabBarItem.selectedImage = UIImage(systemName: "tablecells.fill")
      galleryVC.tabBarItem.title = "Gallery"
      
      return UINavigationController(rootViewController: galleryVC)
   }//
   
   func createSettingNC() -> UINavigationController {
      let settingsVC = SettingsVC()
      settingsVC.tabBarItem.image = UIImage(systemName: "gear")
      settingsVC.tabBarItem.selectedImage = UIImage(systemName: "gear")
      settingsVC.tabBarItem.title = "Settings"
      
      return UINavigationController(rootViewController: settingsVC)
   }//

   
   func configureTabbar() {
       UITabBar.appearance().tintColor = .label
   }
   
   func configureNavigationBar() {
       UINavigationBar.appearance().tintColor = .label
   }

}// Tabbar
