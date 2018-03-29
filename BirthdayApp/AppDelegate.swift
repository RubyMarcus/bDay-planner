//
//  AppDelegate.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-02-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
        -> Bool {
            FirebaseApp.configure()
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {(granted, error) in
                
                
            }
            
            return true
    }
}
