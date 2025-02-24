//
//  LoginViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func goToSignIn(_ sender: Any) {
        let signInVC = SignInViewController()
        signInVC.image = chosenImage
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var profilePictureUpload: UIButton!
    let fullNametextField = SkyFloatingLabelTextField(frame: CGRect(x: 47, y: 350, width: 300, height: 45))
    let emailtextField = SkyFloatingLabelTextField(frame: CGRect(x: 47, y: 420, width: 300, height: 45))
    let passwordtextField = SkyFloatingLabelTextField(frame: CGRect(x: 47, y: 490, width: 300, height: 45))
    
    
    @IBAction func goToProfilePageViewController(_ sender: Any) {
        if (fullNametextField.text == "" || emailtextField.text == "" || passwordtextField.text == "") {
            
            let alert = UIAlertController(title: "Error", message: "Please fill in all the fields before proceeding.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

            self.present(alert, animated: true)
            
        } else {
            let profileVC = ProfileViewController()
            profileVC.image = chosenImage
            profileVC.modalPresentationStyle = .fullScreen
            profileVC.name = fullNametextField.text ?? ""
            present(profileVC, animated: true, completion: nil)
        }
    }
    
    let imagePicker = UIImagePickerController()
    var chosenImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let highlightColor = UIColor(red:0.58, green:0.78, blue:0.84, alpha:1.0)
        

        fullNametextField.placeholder = "Full Name"
        fullNametextField.title = "Full Name"
        
        fullNametextField.tintColor = highlightColor
        fullNametextField.textColor = UIColor.black
        fullNametextField.lineColor = highlightColor
        fullNametextField.titleColor = highlightColor
        fullNametextField.selectedTitleColor = highlightColor
        fullNametextField.selectedLineColor = highlightColor
        self.view.addSubview(fullNametextField)
        
        
        emailtextField.placeholder = "What's your email?"
        emailtextField.title = "What's your email?"
        
        emailtextField.tintColor = highlightColor
        emailtextField.textColor = UIColor.black
        emailtextField.lineColor = highlightColor
        emailtextField.titleColor = highlightColor
        emailtextField.selectedTitleColor = highlightColor
        emailtextField.selectedLineColor = highlightColor
        self.view.addSubview(emailtextField)
        
        passwordtextField.placeholder = "Create a password"
        passwordtextField.title = "Create a password"
        
        passwordtextField.tintColor = highlightColor
        passwordtextField.textColor = UIColor.black
        passwordtextField.lineColor = highlightColor
        passwordtextField.titleColor = highlightColor
        passwordtextField.selectedTitleColor = highlightColor
        passwordtextField.selectedLineColor = highlightColor
        passwordtextField.isSecureTextEntry = true
        self.view.addSubview(passwordtextField)
        
        profilePictureUpload.backgroundColor = UIColor.clear
        profilePictureUpload.layer.cornerRadius = profilePictureUpload.frame.size.width/2
        profilePictureUpload.layer.borderWidth = 0.5
        profilePictureUpload.layer.borderColor = UIColor.gray.cgColor
        
        profilePictureUpload.addTarget(nil, action: #selector(uploadPicture), for: .touchUpInside)
    }
    
    @objc func uploadPicture() {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
            profilePictureUpload.setBackgroundImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
