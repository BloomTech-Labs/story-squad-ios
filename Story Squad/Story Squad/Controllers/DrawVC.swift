//
//  DrawVC.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/17/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class DrawVC: UIViewController {
   
   // Outlets
   let backView = UIView()
   let topView = UIView()
   let middleView = UIView()
   let lineView = UIView()
   let bottomView = UIView()
   
   lazy var mainStackView: UIStackView = {
      let stackView = UIStackView()
       stackView.distribution = .fill
       stackView.spacing = 5
//       stackView.setCustomSpacing(100, after: middleView)
       stackView.axis = .vertical
       return stackView
   }()
   
   
// Top View
   
   let titleLabel: UILabel = {
      let title = UILabel()
      title.textColor = .white
      title.text = " YOUR MISSION "
      title.font = UIFont(name: "Bangers", size: 40.0)
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
   }()
   
// Middle View
   
   lazy var titleStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.distribution = .equalSpacing
      stackView.spacing = 15
      stackView.axis = .horizontal
      return stackView
   }()
   
   let iconLeftView = UIView()
   let iconMiddleView = UIView()
   let iconRightView = UIView()
   
   let iconLeft = UIView()
   let iconMiddle = UIView()
   let iconRight = UIView()
   
   let iconOne: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.tabbarColor
      label.text = "1"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let iconTwo: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.tabbarColor
      label.text = "2"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let iconthree: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.tabbarColor
      label.text = "3"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let readLabel: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.white
      label.text = "Read"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   
   let drawLabel: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.whiteDarkColor
      label.text = "Draw"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let writeLabel: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.whiteDarkColor
      label.text = "Write"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   
   // Bottom View
   
   lazy var botomStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.distribution = .fill
      stackView.spacing = 20
      stackView.axis = .vertical
      return stackView
   }()
   
   
   let pencilLabel: UILabel = {
      let label = UILabel()
      label.textColor = .white
      label.text = " PENCILS READY! "
      label.font = UIFont(name: "Bangers", size: 40.0)
      label.textAlignment = NSTextAlignment.center
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let favoriteLabel: UILabel = {
      let label = UILabel()
      label.textColor = .white
      label.text = "Draw your favorite part of the story, then \ntake a picture and upload it."
      label.font = UIFont(name: "Atma", size: 18.0)
      label.textAlignment = NSTextAlignment.center
      label.numberOfLines = 2
      return label
   }()
   
   let drawImageIcon: UIImageView = {
      let image = UIImageView()
      image.image = UIImage(named: "drawImage")
      image.contentMode = .scaleAspectFit
      return image
   }()
   
   let bottomMiddleView = UIView()
   
   let takePicture: UIButton = {
      let button = UIButton()
      button.setTitleColor(.gray, for: .normal)
      button.setTitle("Upload your drawing", for: .normal)
      button.titleLabel?.font =  UIFont(name: "Bangers", size: 20.0)
      button.backgroundColor = UIColor.aquaColor
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
   }()
   
   

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
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
      mainStackView.addArrangedSubview(lineView)
      mainStackView.addArrangedSubview(bottomView)
      mainStackView.anchor(
         top: backView.topAnchor, leading: backView.leadingAnchor, trailing: backView.trailingAnchor, bottom: backView.bottomAnchor
      )
      
      topView.addSubviewsUsingAutolayout(titleLabel)
      topView.anchor(
         top: mainStackView.topAnchor, leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: backView.frame.width, height: 75)
      )
      topView.backgroundColor = UIColor.tabbarColor
      
      titleLabel.anchor(
         top: topView.topAnchor, bottom: topView.bottomAnchor, centerX: topView.centerXAnchor, centerY: topView.centerYAnchor, padding: .init(top: 15, left: 20, bottom: -15, right: -20)
      )
      
   // Middle View Constraint
      
      middleView.addSubviewsUsingAutolayout(titleStackView)
      middleView.anchor(
          leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: backView.frame.width, height: 100)
      )
     middleView.backgroundColor = UIColor.tabbarColor
     
     titleStackView.addArrangedSubview(iconLeftView)
     titleStackView.addArrangedSubview(iconMiddleView)
     titleStackView.addArrangedSubview(iconRightView)
     titleStackView.anchor(
        top: middleView.topAnchor, leading: middleView.leadingAnchor, trailing: middleView.trailingAnchor, bottom: middleView.bottomAnchor, padding: .init(top: 10, left: 40, bottom: -10, right: -40)
     )
     
     iconLeftView.addSubviewsUsingAutolayout(iconLeft, readLabel)
     iconLeftView.anchor(
        size: .init(width: 100, height: 100)
     )
     iconLeftView.backgroundColor = UIColor.tabbarColor
     
     readLabel.anchor(
        top: iconLeft.bottomAnchor, centerX: iconLeft.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0)
     )
     
     iconLeft.addSubviewsUsingAutolayout(iconOne)
     iconLeft.anchor(
        top: iconLeftView.topAnchor, centerX: iconLeftView.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 40)
     )
     iconLeft.layer.cornerRadius = 20
     iconLeft.clipsToBounds = true
      iconLeft.backgroundColor = UIColor.secondLimeGreenColor
     iconOne.anchor(
        centerX: iconLeft.centerXAnchor, centerY: iconLeft.centerYAnchor
     )
     
     iconMiddleView.addSubviewsUsingAutolayout(iconMiddle, drawLabel)
     iconMiddleView.anchor(
        size: .init(width: 100, height: 100)
     )
     iconMiddleView.backgroundColor = UIColor.tabbarColor
     
     drawLabel.anchor(
        top: iconMiddle.bottomAnchor, centerX: iconMiddle.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0)
     )
     
     iconMiddle.addSubviewsUsingAutolayout(iconTwo)
     iconMiddle.anchor(
        top: iconMiddleView.topAnchor, centerX: iconMiddleView.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 40)
     )
     iconMiddle.layer.cornerRadius = 20
     iconMiddle.clipsToBounds = true
     iconMiddle.backgroundColor = UIColor.drawColor
     
     iconTwo.anchor(
        centerX: iconMiddle.centerXAnchor, centerY: iconMiddle.centerYAnchor
     )
     
     
     iconRightView.addSubviewsUsingAutolayout(iconRight, writeLabel)
     iconRightView.anchor(
        size: .init(width: 100, height: 100)
     )
     iconRightView.backgroundColor = UIColor.tabbarColor
     
     writeLabel.anchor(
        top: iconRight.bottomAnchor, centerX: iconRight.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0)
     )
     
     iconRight.addSubviewsUsingAutolayout(iconthree)
     iconRight.anchor(
        top: iconRightView.topAnchor, centerX: iconRightView.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 40)
     )
     iconRight.layer.cornerRadius = 20
     iconRight.clipsToBounds = true
     iconRight.backgroundColor = UIColor.thirdYellowColor
     
     iconthree.anchor(
        centerX: iconRight.centerXAnchor, centerY: iconRight.centerYAnchor
     )
      
      lineView.anchor(
         leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width, height: 3)
      )
      lineView.backgroundColor = UIColor.darkGray
     
   // Bottom View Constraint
      
      bottomView.addSubviewsUsingAutolayout(botomStackView)
      bottomView.anchor(
         leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, bottom: backView.bottomAnchor
      )
      bottomView.backgroundColor = UIColor.tabbarColor
      
      botomStackView.addArrangedSubview(pencilLabel)
      botomStackView.addArrangedSubview(favoriteLabel)
      botomStackView.addArrangedSubview(drawImageIcon)
      botomStackView.addArrangedSubview(takePicture)
      botomStackView.anchor(
         top: bottomView.topAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, bottom: bottomView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0)
      )
      
      pencilLabel.anchor(
         leading: botomStackView.leadingAnchor, trailing: botomStackView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20)
      )
      favoriteLabel.anchor(
         top: pencilLabel.bottomAnchor, centerX: botomStackView.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0)
      )
      drawImageIcon.anchor(
          
      )
      takePicture.anchor(
         leading: botomStackView.leadingAnchor, trailing: botomStackView.trailingAnchor, bottom: bottomView.bottomAnchor, padding: .init(top: 0, left: 50, bottom: -40, right: -50), size: .init(width: bottomView.frame.width, height: 60)
      )
      takePicture.layer.cornerRadius = 10
      takePicture.clipsToBounds = true
      
      
   }//


}// Class
