//
//  HomeViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var profilePicture: UIImageView!
    let identifier = "ReasonsCollectionViewCell"
    
    @IBAction func goToProfile(_ sender: Any) {
        let homeVC = SentimentPopUpViewController()
        present(homeVC, animated: true, completion: nil)
    }
    
    let names = ["ptsd", "climate", "alcohol", "mentalHealth", "createYourOwn"]
    
    @IBOutlet weak var reasonsToMeetCollection: UICollectionView!
    var image: UIImage? = nil
    
    @IBOutlet weak var searchScreen: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let givenImage = image {
            profilePicture.maskCircle(anyImage: givenImage)
        }
        searchScreen.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        searchScreen.attributedPlaceholder = NSAttributedString(string: "🔍 Search for New Interests", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        reasonsToMeetCollection.delegate = self
        reasonsToMeetCollection.dataSource = self
        let nibCell = UINib(nibName: identifier, bundle: nil)
        reasonsToMeetCollection.register(nibCell, forCellWithReuseIdentifier: identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ReasonsCollectionViewCell
        //set the name and image and number
        cell.image.image = UIImage(named: names[indexPath.row])
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let queueController = InQueueViewController()
            queueController.modalPresentationStyle = .fullScreen
            present(queueController, animated: true, completion: nil)
        }
}

extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   self.image = anyImage
  }
}

