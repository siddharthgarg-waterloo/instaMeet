//
//  InQueueViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class InQueueViewController: UIViewController {
    
    var timerTest : Timer?
    var image: UIImage? = nil
    var chosen: String = ""

    @IBAction func goToHomeViewController(_ sender: Any) {
        let homeVC = HomeViewController()
        self.timerTest?.invalidate()
        self.timerTest = nil
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.image = image
        present(homeVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("7682364")
        ref.updateChildValues(["Status": "True" ])
        timerFunction()
    }
    
    func timerFunction() {
        timerTest = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hitTheServer), userInfo: nil, repeats: true)
    }
    
    @objc func hitTheServer() {
        Alamofire.request("https://instameeter.appspot.com/preresponse", method: .post).responseJSON { response in
            print(response.request as Any)   // original url request
            print(response.response as Any) // http url response
                    print(response.result)  // response
                    if let json = response.result.value {
                        if let new = json as? NSDictionary {
                            if let address = new["address"] as? String,
                                let name = new["name"] as? String,
                                let array = new["final_long_lat"] as? [Double] {
                                let long = array[0]
                                let lat = array[1]
                                print(name)
                                self.timerTest?.invalidate()
                                self.timerTest = nil
                                let mapVC = MainMapViewController()
                                mapVC.chosen = self.chosen
                                mapVC.name = name
                                mapVC.address = address
                                mapVC.lat = lat
                                mapVC.long = long
                                mapVC.modalPresentationStyle = .fullScreen
                                mapVC.image = self.image
                                self.present(mapVC, animated: true, completion: nil)
                            }
                        } else {
                            return
                        }
            }
        }
    }
}


