//
//  AppDelegate.swift
//  Geoloc
//
//  Created by Benoit Briatte on 27/11/2019.
//  Copyright © 2019 ESGI. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var firebaseToken: String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            FirebaseApp.configure()
            // todo token
            InstanceID.instanceID().instanceID(handler: { (result, error) in
                 if let error = error {
                     print("Error fetching remote instange ID: \(error)")
                 } else if let result = result {
                     print("Remote instance ID token: \(result.token)")
                 }
             })
        
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UINavigationController(rootViewController:HomeViewController())
            window.makeKeyAndVisible()
            self.window = window
            
            return true
        }
    }
