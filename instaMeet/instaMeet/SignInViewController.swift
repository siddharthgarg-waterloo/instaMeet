//
//  SignInViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignInViewController: UIViewController {

    @IBAction func goToLoginViewController(_ sender: Any) {
        let logInVC = LoginViewController()
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }
    @IBAction func goToHomePageViewController(_ sender: Any) {
        let homeVC = HomeViewController()
        homeVC.image = image
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        
        let highlightColor = UIColor(red:0.58, green:0.78, blue:0.84, alpha:1.0)
        
        let emailtextField = SkyFloatingLabelTextField(frame: CGRect(x: 47, y: 220, width: 300, height: 45))
        emailtextField.placeholder = "Email"
        emailtextField.title = "Email"
        
        emailtextField.tintColor = highlightColor
        emailtextField.textColor = UIColor.black
        emailtextField.lineColor = highlightColor
        emailtextField.titleColor = highlightColor
        emailtextField.selectedTitleColor = highlightColor
        emailtextField.selectedLineColor = highlightColor
        self.view.addSubview(emailtextField)
        
        let passwordtextField = SkyFloatingLabelTextField(frame: CGRect(x: 47, y: 290, width: 300, height: 45))
        passwordtextField.placeholder = "Password"
        passwordtextField.title = "Password"
        
        passwordtextField.tintColor = highlightColor
        passwordtextField.isSecureTextEntry = true
        passwordtextField.textColor = UIColor.black
        passwordtextField.lineColor = highlightColor
        passwordtextField.titleColor = highlightColor
        passwordtextField.selectedTitleColor = highlightColor
        passwordtextField.selectedLineColor = highlightColor
        self.view.addSubview(passwordtextField)
    }

}
