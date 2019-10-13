//
//  AppDelegate.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import Onboard
import GooglePlaces
import GoogleMaps
import Firebase
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var ref: DatabaseReference!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyDsLMfmF5RfeQ_JS8edMKeprgQ4fSM7DcU")
        GMSPlacesClient.provideAPIKey("AIzaSyDsLMfmF5RfeQ_JS8edMKeprgQ4fSM7DcU")
        ref = Database.database().reference()
        
        let firstPage = OnboardingContentViewController(title: nil, body: nil, image: UIImage(named:"onboarding1"), buttonText: nil, action: nil)
        let secondPage = OnboardingContentViewController(title: nil, body: nil, image: UIImage(named:"onboarding2"), buttonText: nil, action: nil)
        let thirdPage = OnboardingContentViewController(title: nil, body: nil, image: UIImage(named:"onboarding3"), buttonText: nil, action: nil)
        thirdPage.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToLogin)))
        
        let onboardingVC = OnboardingViewController(backgroundImage: nil, contents: [firstPage, secondPage, thirdPage])
        self.window?.rootViewController = onboardingVC
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    @objc private func goToLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(loginVC, animated: true, completion: nil)
    }
    
}

