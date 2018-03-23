//
//  LoggedInVC.swift
//  BirthdayApp
//
//  Created by Robin Tapper on 2018-03-15.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoggedInVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var BirthdayList = BirthdayItem()
    var testCell = BirthdayTableViewCell()
    
    @IBOutlet weak var BirthdayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell") as! BirthdayTableViewCell

        cell.nameLabel.text = "\(BirthdayList.item![indexPath.row].firstname)  \(BirthdayList.item![indexPath.row].lastname)"
        
        let birthdayDate = BirthdayList.item![indexPath.row].birthdayDate
        
        let endIndex = birthdayDate.index(birthdayDate.endIndex, offsetBy: -4)
        
        var birthdayYear = birthdayDate.substring(from: endIndex)
        
        var truncated = birthdayDate.substring(to: endIndex)
        
        truncated = truncated + GetCurrentYear()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = dateFormatter.date(from: truncated) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        // Add daylabel.
        
        let days = components.day!
        
        let postiveDays = days.magnitude
        
        var age = Int(GetCurrentYear())! % Int(birthdayYear)!
        
        /*
        if(postiveDays != 0)
        {
            switch age {
            case 0:
                age = 1
                strYear = "year"
            case 2...200:
                strYear = "years"
            default:
                strYear = "years"
            }
            
            cell.ageNDayLabel.text = "\(age) \(strYear) in \(postiveDays) \(strDay)"
        }
        else
        {
            cell.ageNDayLabel.text = strDay
        }
        */
        
        cell.daysLabel.text = "in \(postiveDays) \(getstrDays(days: Int(postiveDays)))"
        
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


