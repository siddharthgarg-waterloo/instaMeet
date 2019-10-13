//
//  SentimentPopUpViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit

class SentimentPopUpViewController: UIViewController {

    @IBOutlet weak var moreInformation: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        moreInformation.clipsToBounds = true
        moreInformation.backgroundColor = .white
        moreInformation.layer.cornerRadius = 10
        moreInformation.layer.borderWidth = 1
        moreInformation.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    

}
