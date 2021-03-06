//
//  AppDelegate.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit
import SecureDefaults

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let defaults = SecureDefaults.shared
        if !defaults.isKeyCreated {
            defaults.password = NSUUID().uuidString
        }
        
        let navVC = UINavigationController(rootViewController: ViewController())
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

