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

    @IBAction func goToHomeViewController(_ sender: Any) {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    let ref = Database.database().reference().child("27567")
                    ref.updateChildValues(["Status": "True" ])
                    Alamofire.request("https://instameeter.appspot.com/preresponse", method: .post).responseJSON { response in
                                print(response.request)   // original url request
                                print(response.response) // http url response
                                print(response.result)  // response
                                if let json = response.result.value {
                                    let new = json as! NSDictionary
                                    if let address = new["address"] as? String,
                                        let name = new["name"] as? String {
                                        print(name)
                                        let mapVC = MainMapViewController()
                                        mapVC.name = name
                                        mapVC.address = address
                                        mapVC.modalPresentationStyle = .fullScreen
                                        self.present(mapVC, animated: true, completion: nil)
                                    }
                        }
                    }
        })
        

    }

}
