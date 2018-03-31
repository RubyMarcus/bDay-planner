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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
        -> Bool {
            FirebaseApp.configure()
            
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {(accepted, error) in
                if !accepted {
                    print("Notification access denied")
                }
            }
            return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // EZAlertController.alert("you have new meeting ")
        
        completionHandler( [.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
