//
//  ProfileViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import WSTagsField

class ProfileViewController: UIViewController {
    
    fileprivate let tagsField = WSTagsField()
    @IBOutlet weak var moreInformation: UITextView!
    
    @IBOutlet weak var tagsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreInformation.clipsToBounds = true
        moreInformation.backgroundColor = .white
        moreInformation.layer.cornerRadius = 10
        moreInformation.layer.borderWidth = 1
        moreInformation.layer.borderColor = UIColor.darkGray.cgColor
        
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)
        
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

}

extension ProfileViewController {

    fileprivate func textFieldEvents() {

        tagsField.onValidateTag = { tag, tags in
            // custom validations, called before tag is added to tags list
            return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
        }
    }

}
