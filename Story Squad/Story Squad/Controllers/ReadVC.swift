//
//  ReadVC.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/16/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class ReadVC: UIViewController {
   
   // Outlets
   let topView = UIView()
   let middleView = UIView()
   let lineView = UIView()
   let bottomView = UIView()
   
   let titleLabel: UILabel = {
      let title = UILabel()
      title.textColor = .white
      title.text = " YOUR MISSION "
      title.font = UIFont(name: "Bangers", size: 40.0)
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
   }()
   
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
   
   let headingLabel: UILabel = {
     let label = UILabel()
      label.textColor = UIColor.white
      label.text = "Zoom & Boom @ A Saltwater Startup"
      label.font = UIFont(name: "Atma", size: 22.0)
      label.textAlignment = NSTextAlignment.center
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let authorLabel: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.white
      label.text = "by Conner Burnham"
      label.font = UIFont(name: "Atma", size: 16.0)
      label.textAlignment = NSTextAlignment.center
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let chapterLabel: UILabel = {
      let label = UILabel()
      label.textColor = .white
      label.text = " YOUR MISSION "
      label.font = UIFont(name: "Bangers", size: 24.0)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let introTextView: UILabel = {
      let textView = UILabel()
      textView.textColor = .white
      textView.font = UIFont(name: "Open Sans", size: 16)
      textView.backgroundColor = UIColor.tabbarColor
      textView.textAlignment = NSTextAlignment.justified
 //     textView.isEditable = false
      textView.lineBreakMode = NSLineBreakMode.byWordWrapping
      textView.numberOfLines = 0
      
      
      textView.text = "In the coral reefs beneath the surface of the ocean, every kid was obsessed with the sport of flipperball. It didn’t matter your species—dolphin, marlin, electric eel. Once school got out for the summer, everyone suited up for their Little League team and spent the season trying to hammer the ball into the back of the net. From the sidelines, dads would brag to anyone who would listen, “Did you see that move? My kid’s gonna make it to the pros and sign a contract for a million clams like Scooter Messy. Just you watch.” This summer pastime wasn’t playing out in local pockets here or there, along this livestream or that. No, the sport’s popularity was surging in reefs underneath every archipelago — from Hawaii to Fiji, Guam to Tahiti and the gobs of tropics in between. The surface temperature of the Pacific was even said to rise an entire degree from the collective outbreak of flipperball fever. \nEven the bottom feeders in the basement of the ocean weren’t immune, although the data from down here was sketchy, as 20,000 leagues was as far down as a reliable signal would go. Any deeper and guppies would start yelling into their devices, “Hello? HELL-O? Mom, can you hear me?” before refreshing their screens and saying, “Zero bars, really? C’mon, c’mon.” Down here, social media didn’t update. Texts wouldn’t transmit. Friends closer to the surface wondered why they were being ghosted. When you toggled over to the Goggle Earth app, the underwater map would look all pixelated. You’d need a real compass and an old school paper map to have any chance of navigating, unless of course you grew up around these parts and knew the lay of the sand like the back of your fin."
      return textView
   }()
   
   let awesomeButton: UIButton = {
      let button = UIButton()
      button.setTitleColor(.gray, for: .normal)
      button.setTitle("I'm awesome, I'm done reading!", for: .normal)
      button.titleLabel?.font =  UIFont(name: "Bangers", size: 20.0)
      button.backgroundColor = UIColor.aquaColor
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(handleAwesomeButton), for: .touchUpInside)
      return button
   }()
   
   
   
// Background and Scroll UI
   
   lazy var containerView: UIView = {
       let view = UIView()
//      view.backgroundColor = UIColor.systemBlue
       return view
   }()
   
   lazy var scrollStackView: UIStackView = {
      let stackView = UIStackView()
       stackView.distribution = .fill
       stackView.spacing = 0
       stackView.axis = .vertical
       return stackView
   }()
   
   lazy var scrollView: UIScrollView = {
       let view = UIScrollView(frame: .zero)
//      view.backgroundColor = UIColor.systemPink
       view.frame = view.bounds
       return view
   }()
   
   lazy var mainStackView: UIStackView = {
      let stackView = UIStackView()
       stackView.distribution = .fill
       stackView.spacing = 5
//       stackView.setCustomSpacing(100, after: middleView)
       stackView.axis = .vertical
       return stackView
   }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.tabbarColor
        
      configureUI()
    }
   
   @objc func handleAwesomeButton() {
      let rootVC = DrawVC()
      navigationController?.pushViewController(rootVC, animated: true)
   }
    

   func configureUI() {
      mainStackView.addArrangedSubview(topView)
      mainStackView.addArrangedSubview(middleView)
      mainStackView.addArrangedSubview(lineView)
      mainStackView.addArrangedSubview(bottomView)
      configureTopView()
      configureMiddleView()
      configureLineView()
      configureBottomView()
      
      containerView.addSubview(mainStackView)
      configureMainStackView()
      
      scrollStackView.addArrangedSubview(containerView)
      scrollView.addSubviewsUsingAutolayout(scrollStackView)
      configureScrollStackView()
      
      view.addSubviewsUsingAutolayout(scrollView)
      configureScrollView()
   }
   
   
   func configureBottomView() {
      bottomView.addSubviewsUsingAutolayout(headingLabel, authorLabel, chapterLabel, introTextView, awesomeButton)
       bottomView.anchor(
           leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: 0)
       )
      bottomView.backgroundColor = UIColor.tabbarColor
      
      headingLabel.anchor(
         top: bottomView.topAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, padding: .init(top: 20, left: 15, bottom: 0, right: -15)
      )
      authorLabel.anchor(
         top: headingLabel.bottomAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, padding: .init(top: 10, left: 15, bottom: 0, right: -15)
      )
      chapterLabel.anchor(
         top: authorLabel.bottomAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: -20)
      )
      introTextView.anchor(
         top: chapterLabel.bottomAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: -20)
      )
      
      awesomeButton.anchor(
         top: introTextView.bottomAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, bottom: bottomView.bottomAnchor, padding: .init(top: 50, left: 40, bottom: -50, right: -40), size: .init(width: bottomView.frame.width, height: 60)
      )
      
      awesomeButton.layer.cornerRadius = 10
      awesomeButton.clipsToBounds = true
      
   }//
   
   
   func configureLineView() {
      lineView.anchor(
         leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width, height: 3)
      )
      lineView.backgroundColor = UIColor.darkGray
   }
   
   
   func configureMiddleView() {
       middleView.addSubviewsUsingAutolayout(titleStackView)
       middleView.anchor(
           leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: 0)
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
      iconLeft.backgroundColor = UIColor.limeGreenColor
      
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
      iconMiddle.backgroundColor = UIColor.secondOrangeColor
      
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
      
   }//
   
   
   func configureTopView() {
       topView.addSubviewsUsingAutolayout(titleLabel)
       topView.anchor(
           top: mainStackView.topAnchor, leading: mainStackView.leadingAnchor, trailing: mainStackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: 0)
       )
      topView.backgroundColor = UIColor.tabbarColor
      
      titleLabel.anchor(
         top: topView.topAnchor, bottom: topView.bottomAnchor, centerX: topView.centerXAnchor, centerY: topView.centerYAnchor, padding: .init(top: 15, left: 20, bottom: -15, right: -20)
      )
      
   }//
   
   
   
   
   func configureMainStackView() {
       mainStackView.anchor(
           top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: -15, right: 0)
       )
   }//
   
   
   func configureScrollStackView() {
       scrollStackView.anchor(
           top: scrollView.contentLayoutGuide.topAnchor, leading: scrollView.contentLayoutGuide.leadingAnchor, trailing: scrollView.contentLayoutGuide.trailingAnchor, bottom: scrollView.contentLayoutGuide.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 0)
       )
       
       containerView.anchor(
           top: scrollStackView.topAnchor, leading: scrollStackView.leadingAnchor, trailing: scrollStackView.trailingAnchor, bottom: scrollStackView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollStackView.frame.width, height: 0)
       )
   }//
   
   
   func configureScrollView() {
       scrollView.anchor(
           top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height)
       )
   }//



}// Class
