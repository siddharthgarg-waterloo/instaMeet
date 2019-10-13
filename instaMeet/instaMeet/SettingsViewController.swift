//
//  SettingsViewController.swift
//  instaMeet
//
//  Created by Siddharth on 13/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import SwiftChart
import FirebaseDatabase
import Firebase

class SettingsViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var image: UIImage? = nil

    @IBOutlet weak var chart: Chart!
    
    @IBAction func goToHomeViewController(_ sender: Any) {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.image = image
        present(homeVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var profile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile.isEnabled = false
        
        ref = Database.database().reference()
        
        ref.child("7682364").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            if let value = snapshot.value as? NSDictionary {
                if let array = value["Sentiments"] as? [Double] {
                    let series = ChartSeries(array)
                    series.area = true
                    self.chart.add(series)

                    // Set minimum and maximum values for y-axis
                    self.chart.minY = -100
                    self.chart.maxY = 100
                }
            }
          }) { (error) in
            print(error.localizedDescription)
        }
    }

}
