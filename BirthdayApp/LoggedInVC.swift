//
//  LoggedInVC.swift
//  BirthdayApp
//
//  Created by Robin Tapper on 2018-03-15.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit
import FirebaseAuth
import UserNotifications


class LoggedInVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static var reminders = [Reminder]()
    let dateFormatter = DateFormatter()
    let locale = NSLocale.autoupdatingCurrent
    
    var BirthdayList = BirthdayItem()
    var testCell = BirthdayTableViewCell()
    
    @IBOutlet weak var BirthdayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BirthdayTableView.allowsMultipleSelectionDuringEditing = false
        
        if let savedReminders = loadReminders() {
            LoggedInVC.reminders += savedReminders
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Notification
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(Auth.auth().currentUser == nil)
        {
            print("INTE INLOGGAD")
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            print("INLOGGAD")
            print(Auth.auth().currentUser?.uid)
            
            BirthdayList.LoadData(completion: {(result : Bool) in
                
                self.navigationItem.title = Auth.auth().currentUser?.email
                
                self.BirthdayTableView.reloadData()
            })
        }
        
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        for item in LoggedInVC.reminders {
            print(item.name)
            print(item.notification)
            print(item.time)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let itemcount = BirthdayList.item?.count
        {
            return itemcount
        }
        return 0
        
    }
    
    func GetCurrentYear () -> String
    {
        
        let date = Date()
        
        let yearString = date.getYear()
        
        return yearString
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let tempBirthdayItem = BirthdayItem()
        
        tempBirthdayItem.fbKey = BirthdayList.item![indexPath.row].fbKey
        
        self.BirthdayList.deleteItem(item: tempBirthdayItem, completion: {(result : Bool) in
            
            self.BirthdayList.item?.removeAll()
            
            self.BirthdayList.LoadData(completion: {(result : Bool) in
                
                if(LoggedInVC.reminders.count != nil)
                {
                    LoggedInVC.reminders.remove(at: indexPath.row)
                    
                    LoggedInVC.saveReminders()
                    
                }
                
                self.BirthdayTableView.reloadData()
            })
            
        })
        
        
    }
    
    static func saveReminders () {
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(LoggedInVC.reminders, toFile: Reminder.ArchiveUrl.path)
        if (isSuccesfulSave) { print ("Saved Reminders Succesfully")}
        else { print("Failed to Save reminders :(")}
    }
    
    func loadReminders () -> [Reminder]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Reminder.ArchiveUrl.path) as? [Reminder]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell") as! BirthdayTableViewCell

        cell.nameLabel.text = "\(BirthdayList.item![indexPath.row].firstname)  \(BirthdayList.item![indexPath.row].lastname)"
        
        let birthdayDate = BirthdayList.item![indexPath.row].birthdayDate
        
        let endIndex = birthdayDate.index(birthdayDate.endIndex, offsetBy: -4)
        
        var birthdayYear = birthdayDate.substring(from: endIndex)
        
        var truncated = birthdayDate.substring(to: endIndex)
        
        var currentBirthdayYear = truncated + GetCurrentYear()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard var date = dateFormatter.date(from: currentBirthdayYear) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        var date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())
        
        if(date2 > date1)
        {
            let currentYear = Int(GetCurrentYear())! + 1
            
            print(currentYear)
            
            truncated = truncated + String(currentYear)
            
            
            
            guard let datetest = dateFormatter.date(from: truncated) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            date1 = datetest
        }
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        // Add daylabel.
        
        let days = components.day!
        
        let postiveDays = days.magnitude
        
        var age = Int(GetCurrentYear())! % Int(birthdayYear)!
        
        var strAge = ""
        
        if(postiveDays == 0)
        {
            cell.ageLabel.text = ""
        }
        else if (age == 0){
            
            strAge = "year"
            
            if (age == 0)
            {
                age = 1
            }
            
            cell.ageLabel.text = "\(age) \(strAge)"
        }
        else {
            
            strAge = "years"
            
            if (age == 0)
            {
                age = 1
            }
            
            cell.ageLabel.text = "\(age) \(strAge)"
            
        }
        
        let getStrDay = getstrDays(days: Int(postiveDays))
        
        if(getStrDay == "Happy Birthday")
        {
            cell.ageLabel.text = "Happy"
            cell.daysLabel.text = "Birthday"
        }
        else {
            
                 cell.daysLabel.text = "in \(postiveDays) \(getStrDay)"
        }
        
        return cell
        
    }
    
    func getstrDays (days : Int) -> String
    {
        switch days  {
        case 1:
            return "day"
        case 2...370:
            return "days"
        default:
            return "Happy Birthday"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detail")
        {
            let dest = segue.destination as! DetailViewController
            
            dest.tempItem = BirthdayList.item![sender as! Int]
        }
        
    }
    
    
    // Account function
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            
            //dismiss(animated: true, completion: nil)
            
            performSegue(withIdentifier: "login", sender: nil)
            
        }catch{
            print("There was a problem logging out")
        }
    }
}

extension Date {
    
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let strYear = dateFormatter.string(from: self)
        return strYear
    }
    
}


