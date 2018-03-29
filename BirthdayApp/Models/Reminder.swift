//
//  Reminder.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-28.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject, NSCoding {
    
    //Properties
    var notification: UILocalNotification
    var name: String
    var time: Date
    
    //Archive paths for persistent Data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("reminders")
    
    // enum for property keys
    struct PropertyKey {
        static let nameKey = "name"
        static let timeKey = "time"
        static let notificationKey = "notification"
    }
    
    // Initializer
    init(name: String, time: Date, notification: UILocalNotification) {
        self.name = name
        self.time = time
        self.notification = notification
        
        super.init()
    }
    
    //Destructor
    deinit {
        //cancel notification
        UIApplication.shared.cancelLocalNotification(self.notification)
        
    }
    
    // NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(time, forKey: PropertyKey.timeKey)
        aCoder.encode(notification, forKey: PropertyKey.notificationKey)
    }
    
    required convenience init (coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let time = aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! Date
        let notification = aDecoder.decodeObject(forKey: PropertyKey.notificationKey) as! UILocalNotification
        
        self.init(name: name, time: time, notification: notification)
    }
}
