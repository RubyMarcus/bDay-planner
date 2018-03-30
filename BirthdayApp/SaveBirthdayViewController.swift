//
//  SaveBirthdayViewController.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit

class SaveBirthdayViewController: UIViewController {

    var reminder: Reminder?
    
    var birthdayList = BirthdayItem()
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var BirthdayList = BirthdayItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func CreateBirthday(_ sender: Any) {

        guard let firstname = firstnameTextField.text, firstname != "" else {
        
            let alert = UIAlertController(title: "Error", message: "Fyll i förnamn.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
         
        }
        
        guard let lastname = lastnameTextField.text, lastname != "" else {
            
            let alert = UIAlertController(title: "Error", message: "Fyll i efternamn.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        let tempItem = BirthdayItem()
        
        tempItem.firstname = firstnameTextField.text!
        tempItem.lastname = lastnameTextField.text!
        
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        tempItem.birthdayDate = selectedDate
        
        self.BirthdayList.SaveBirthday(item: tempItem, completion: {(result: Bool) in
            
            self.navigationController?.popViewController(animated: true)
            
            self.firstnameTextField.text = ""
            self.lastnameTextField.text = ""
            
            let gregorian = Calendar(identifier: .gregorian)
            var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.datePicker.date)
            
            // Change the time to 9:30:00 in your locale
            // If date is grater than current date change year
            
            components.year = Int(self.GetCurrentYear()) // test
            components.hour = 08
            components.minute = 00
            components.second = 00
            
            let date = gregorian.date(from: components)!
            
            let name = "\(tempItem.firstname) \(tempItem.lastname)"
            
            let time = date
            
            let notification = UILocalNotification()
            notification.alertTitle = "Birthday Reminder"
            notification.alertBody = "Today is \(tempItem.firstname) \(tempItem.lastname)'s birthday!"
            notification.fireDate = time
            notification.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.shared.scheduleLocalNotification(notification)
            
            self.reminder = Reminder(name: name, time: time, notification: notification)
            
            LoggedInVC.reminders.append(self.reminder!)
            
            LoggedInVC.saveReminders(completion: {(result: Bool) in
                
                
            })
        })
        
        
    }
    
    func GetCurrentYear () -> String
    {
        
        let date = Date()
        
        let yearString = date.getYear()
        
        return yearString
        
    }

}
