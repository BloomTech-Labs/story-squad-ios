//
//  LoginVC.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/15/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
   
   // Outlets
   let backView = UIView()
   
   let topView = UIView()
   
   let middleView = UIView()
   
   let bottomView = UIView()
   
   lazy var mainStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.distribution = .fillEqually
      stackView.spacing = 20
      stackView.axis = .vertical
      return stackView
   }()
   
//   let titleLabel: UILabel = {
//      let title = UILabel()
//      title.textColor = .white
//      title.text = " STORY SQUAD "
//      title.font = UIFont(name: "Bangers", size: 42.0)
//      title.translatesAutoresizingMaskIntoConstraints = false
//      return title
//   }()
   
   
   
   lazy var titleLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
      label.attributedText = strokedTextStorage
      return label
   }()
   
   lazy var strokedTextStorage: NSTextStorage = {

      var textStorage = NSTextStorage(string: " STORY SQUAD ", attributes: [NSAttributedString.Key.strokeWidth: -4.0, NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Bangers-Regular", size: 50) ?? UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.obliqueness: 0.0])

      return textStorage

   }()

   
   let subTitleLabel: UILabel = {
      let title = UILabel()
      title.textColor = UIColor.subTitleColor
      title.text = "Sign-in to your account"
      title.font = UIFont(name: "Open Sans", size: 18.0)
      title.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
   }()
   
   let emailAddressLabel: UILabel = {
      let label = UILabel()
      label.textColor = UIColor.subTitleColor
      label.text = "Email Adress"
      label.font = UIFont(name: "Open Sans", size: 14.0)
      label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
      return label
   }()
   
   let emailTextField: UITextField = {
      let email = EmailTextField()
      return email
   }()
   
   let loginButton: UIButton = {
      let button = UIButton()
//      button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
      button.setTitleColor(.white, for: .normal)
      button.setTitle("NEXT", for: .normal)
      button.titleLabel?.font =  UIFont(name: "Mulish", size: 15.0)
      button.backgroundColor = UIColor.tabbarColor
      button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
   }()
   
   let createAccountButton: UIButton = {
      let button = UIButton()
      button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
      button.setTitleColor(.darkGray, for: .normal)
      button.setTitle("First time? CREATE AN ACCOUNT HERE", for: .normal)
      button.backgroundColor = UIColor.clear
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
   }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.aquaColor
        
      configureUI()
    }
   
   
   @objc func handleLoginButton() {
      
      let modal = MainTabbarVC()
      modal.modalPresentationStyle = .fullScreen
      present(modal, animated: true, completion: nil)
      print("tapped")
      
//      let rootVC = MissionVC()
//      navigationController?.pushViewController(rootVC, animated: true)
   }
   
   
   
   override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
   }
   
   func configureUI() {
      view.addSubviewsUsingAutolayout(backView)
      setupBackView()
   }//
   
   func setupBackView() {
      backView.addSubviewsUsingAutolayout(mainStackView)
      backView.anchor(
         top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor
      )
      backView.translatesAutoresizingMaskIntoConstraints = false
      
      mainStackView.addArrangedSubview(topView)
      mainStackView.addArrangedSubview(middleView)
      mainStackView.addArrangedSubview(bottomView)
      mainStackView.anchor(
         top: backView.topAnchor, leading: backView.leadingAnchor, trailing: backView.trailingAnchor, bottom: backView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0)
      )
      
      
      let topViewHeight = (UIScreen.main.bounds.width / 2) + 40
      
      topView.addSubviewsUsingAutolayout(titleLabel, subTitleLabel)
      topView.anchor(
         
      )
      topView.translatesAutoresizingMaskIntoConstraints = false
      topView.backgroundColor = UIColor.aquaColor
      
      titleLabel.anchor(
         centerX: topView.centerXAnchor, centerY: topView.centerYAnchor
      )
      
      subTitleLabel.anchor(
         top: titleLabel.bottomAnchor, centerX: titleLabel.centerXAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0)
      )
      
      
      middleView.addSubviewsUsingAutolayout(emailAddressLabel, emailTextField, loginButton)
      middleView.anchor(
         size: .init(width: backView.frame.width, height: 250)
      )
      middleView.translatesAutoresizingMaskIntoConstraints = false
      middleView.backgroundColor = UIColor.aquaColor
      
      emailAddressLabel.anchor(
         leading: middleView.leadingAnchor, trailing: middleView.trailingAnchor, bottom: emailTextField.topAnchor, padding: .init(top: 0, left: 35, bottom: -10, right: -30)
      )
      
      let emailHeight = UIScreen.main.bounds.width / 7
      
      emailTextField.anchor(
         leading: middleView.leadingAnchor, trailing: middleView.trailingAnchor, bottom: loginButton.topAnchor, padding: .init(top: 0, left: 25, bottom: -25, right: -25), size: .init(width: middleView.frame.width, height: emailHeight)
      )
      emailTextField.layer.borderWidth = 1
      emailTextField.layer.borderColor = UIColor.gray.cgColor
      emailTextField.layer.cornerRadius = emailHeight / 2
      emailTextField.clipsToBounds = true
      
      
      loginButton.anchor(
         leading: middleView.leadingAnchor, trailing: middleView.trailingAnchor, centerX: middleView.centerXAnchor, centerY: middleView.centerYAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: -25), size: .init(width: middleView.frame.width, height: emailHeight)
      )
      loginButton.layer.borderWidth = 1
      loginButton.layer.borderColor = UIColor.white.cgColor
      loginButton.layer.cornerRadius = emailHeight / 2
      loginButton.clipsToBounds = true
      
      bottomView.addSubviewsUsingAutolayout(createAccountButton)
      bottomView.anchor(
        
      )
      bottomView.translatesAutoresizingMaskIntoConstraints = false
      bottomView.backgroundColor = UIColor.aquaColor
      
      createAccountButton.anchor(
         leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, bottom: bottomView.bottomAnchor, padding: .init(top: 0, left: 30, bottom: -80, right: -30)
      )
      
   }//
   
    


}// Class
