//
//  SentimentPopUpViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import Alamofire

class SentimentPopUpViewController: UIViewController {

    var currentSelectedIndex = 0
    
    @IBOutlet weak var neutral: UIButton!
    @IBOutlet weak var happy: UIButton!
    @IBOutlet weak var sad: UIButton!
    
    @IBOutlet weak var moreInformation: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        moreInformation.clipsToBounds = true
        moreInformation.textColor = .black
        moreInformation.backgroundColor = .white
        moreInformation.layer.cornerRadius = 10
        moreInformation.layer.borderWidth = 1
        moreInformation.layer.borderColor = UIColor.darkGray.cgColor
        neutral.addTarget(nil, action: #selector(neutralButton), for: UIControl.Event.touchUpInside)
        happy.addTarget(nil, action: #selector(happyButton), for: UIControl.Event.touchUpInside)
        sad.addTarget(nil, action: #selector(sadButton), for: UIControl.Event.touchUpInside)
        
    }
    
    
    @IBAction func submitSentiment(_ sender: Any) {
        if let information = moreInformation.text { Alamofire.request("https://instameeter.appspot.com/postresponse", method: .post, parameters: ["id": "7682364", "userfeedback": information],encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                print(response.request as Any)   // original url request
                print(response.response as Any) // http url response
            print(response.result)  // response
            if let json = response.result.value {
                print(json)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func neutralButton() {
        if currentSelectedIndex == 2 {
            neutral.setBackgroundImage(UIImage(named: "blackOkay"), for: .normal)
            currentSelectedIndex = 0
        } else {
            if currentSelectedIndex == 1 {
                happy.setBackgroundImage(UIImage(named: "blackHappy"), for: .normal)
            } else if currentSelectedIndex == 3 {
                sad.setBackgroundImage(UIImage(named: "blackSad"), for: .normal)
            }
            neutral.setBackgroundImage(UIImage(named: "yellowOkay"), for: .normal)
            currentSelectedIndex = 2
        }
    }
    
    @objc func sadButton() {
        if currentSelectedIndex == 3 {
            sad.setBackgroundImage(UIImage(named: "blackSad"), for: .normal)
            currentSelectedIndex = 0
        } else {
            if currentSelectedIndex == 1 {
                happy.setBackgroundImage(UIImage(named: "blackHappy"), for: .normal)
            } else if currentSelectedIndex == 2 {
                neutral.setBackgroundImage(UIImage(named: "blackOkay"), for: .normal)
            }
            sad.setBackgroundImage(UIImage(named: "redSad"), for: .normal)
            currentSelectedIndex = 3
        }
    }
    
    @objc func happyButton() {
        if currentSelectedIndex == 1 {
            happy.setBackgroundImage(UIImage(named: "blackHappy"), for: .normal)
            currentSelectedIndex = 0
        } else {
            if currentSelectedIndex == 3 {
                sad.setBackgroundImage(UIImage(named: "blackSad"), for: .normal)
            } else if currentSelectedIndex == 2 {
                neutral.setBackgroundImage(UIImage(named: "blackOkay"), for: .normal)
            }
            happy.setBackgroundImage(UIImage(named: "greenHappy"), for: .normal)
            currentSelectedIndex = 1
        }
    }
    
}
