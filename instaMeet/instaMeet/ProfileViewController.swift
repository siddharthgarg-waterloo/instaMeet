//
//  ProfileViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import WSTagsField

class ProfileViewController: UIViewController, UITextViewDelegate {

    @IBAction func goToHomeViewController(_ sender: Any) {
        if (moreInformation.text == "" || tagsField.tags.count == 0) {
            let alert = UIAlertController(title: "Error", message: "Please fill in all the fields before proceeding.", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

                       self.present(alert, animated: true)
        } else {
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            homeVC.image = image
            present(homeVC, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var image: UIImage? = nil
    var name: String = ""
    
    @IBOutlet weak var profilePicture: UIImageView!
    fileprivate let tagsField = WSTagsField()
    @IBOutlet weak var moreInformation: UITextView!
    
    @IBOutlet weak var tagsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if let givenImage = image {
            profilePicture.maskCircle(anyImage: givenImage)
        }
        
        moreInformation.delegate = self
        
        moreInformation.clipsToBounds = true
        moreInformation.backgroundColor = .white
        moreInformation.layer.cornerRadius = 10
        moreInformation.layer.borderWidth = 1
        moreInformation.layer.borderColor = UIColor.darkGray.cgColor
        moreInformation.text = "Looking to meet new people with a similar mind set."
        moreInformation.textColor = UIColor.lightGray
        
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)
        
        welcomeLabel.text = "Welcome, " + name + "!"
        
        tagsField.placeholder = "🔍 Ex. Camping, Video Gaming, Cooking ... etc."
        
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.spaceBetweenLines = 5.0
        tagsField.spaceBetweenTags = 10.0
        tagsField.font = .systemFont(ofSize: 12.0)
        tagsField.backgroundColor = .white
        tagsField.tintColor = UIColor(red:0.58, green:0.78, blue:0.84, alpha:1.0)
        tagsField.textColor = .white
        tagsField.fieldTextColor = UIColor(red:0.58, green:0.78, blue:0.84, alpha:1.0)
        tagsField.isDelimiterVisible = false
        tagsField.placeholderColor = UIColor(red:0.58, green:0.78, blue:0.84, alpha:1.0)
        tagsField.placeholderAlwaysVisible = false
        tagsField.keyboardAppearance = .dark
        tagsField.returnKeyType = .next
        tagsField.acceptTagOption = .space
        
        textFieldEvents()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Looking to meet new people with a similar mind set."
            textView.textColor = UIColor.lightGray
        }
    }

}

extension ProfileViewController {

    fileprivate func textFieldEvents() {

        tagsField.onValidateTag = { tag, tags in
            // custom validations, called before tag is added to tags list
            return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
        }
    }

}
