//
//  MissionVC.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/15/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class MissionVC: UIViewController {
   
   // Outlets
   let backView = UIView()
   
   let topView = UIView()
   
   let missionButton: UIButton = {
      let button = UIButton()
//      button.setTitle(" ACCEPT \n THE MISSION ", for: .normal)
//      button.titleLabel?.textAlignment = NSTextAlignment.center
//      button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//      button.setTitleColor(UIColor.tabbarColor, for: .normal)
//      button.titleLabel?.font =  UIFont(name: "Bangers", size: 42)
      button.setImage(UIImage(named: "acceptMission-1"), for: UIControl.State.normal)
      button.addTarget(self, action: #selector(handleMissionButton), for: .touchUpInside)
      button.backgroundColor = UIColor.readColor
      return button
   }()
   
   
   let middleView = UIView()
   
   let leaderboardButton: UIButton = {
      let button = UIButton()
      button.setTitle(" LEADERBOARD ", for: .normal)
      button.setTitleColor(UIColor.borderColor, for: .normal)
      button.titleLabel?.font =  UIFont(name: "Bangers", size: 28)
      button.backgroundColor = UIColor.drawColor
      return button
   }()
   
   let bottomView = UIView()
   
   let galleryButton: UIButton = {
      let button = UIButton()
      button.setTitle(" STORY AND DRAWING \n GALLERY ", for: .normal)
      button.titleLabel?.textAlignment = NSTextAlignment.center
      button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
      button.setTitleColor(UIColor.borderColor, for: .normal)
      button.titleLabel?.font =  UIFont(name: "Bangers", size: 28)
      button.backgroundColor = UIColor.writeColor
      return button
   }()
   
   lazy var mainStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.distribution = .fillEqually
      stackView.spacing = 40
      stackView.axis = .vertical
      return stackView
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.tabbarColor
      navigationItem.title = "Accept the Mission"
      self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bangers", size: 20)!]
      
      
      configureUI()
    }
   
   @objc func handleMissionButton() {
      let rootVC = ReadVC()
      navigationController?.pushViewController(rootVC, animated: true)
   }//
   
   
   
   
   
   
    

   func configureUI() {
      view.addSubviewsUsingAutolayout(backView)
      setupBackView()
   }//
   
   func setupBackView() {
      backView.addSubviewsUsingAutolayout(mainStackView)
      backView.anchor(
         top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor
      )
      backView.backgroundColor = UIColor.tabbarColor
      
      mainStackView.addArrangedSubview(topView)
      mainStackView.addArrangedSubview(middleView)
      mainStackView.addArrangedSubview(bottomView)
      mainStackView.anchor(
         top: backView.topAnchor, leading: backView.leadingAnchor, trailing: backView.trailingAnchor, bottom: backView.bottomAnchor, padding: .init(top: 40, left: 0, bottom: -40, right: 0)
      )
      
      topView.addSubviewsUsingAutolayout(missionButton)
      topView.layer.borderWidth = 7
      topView.layer.borderColor = UIColor.borderColor?.cgColor
      missionButton.anchor(
         top: topView.topAnchor, leading: topView.leadingAnchor, trailing: topView.trailingAnchor, bottom: topView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0)
      )
      
      middleView.addSubviewsUsingAutolayout(leaderboardButton)
      middleView.layer.borderWidth = 7
      middleView.layer.borderColor = UIColor.borderColor?.cgColor
      leaderboardButton.anchor(
         top: middleView.topAnchor, leading: middleView.leadingAnchor, trailing: middleView.trailingAnchor, bottom: middleView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0)
      )
      
      bottomView.addSubviewsUsingAutolayout(galleryButton)
      bottomView.layer.borderWidth = 7
      bottomView.layer.borderColor = UIColor.borderColor?.cgColor
      galleryButton.anchor(
         top: bottomView.topAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, bottom: bottomView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0)
      )
      
   }// setup


}// Class
