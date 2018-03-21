//
//  BirthdayItem.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import Foundation
import Firebase

class BirthdayItem {

    //var ref: DatabaseReference!
    
    var firstname = ""
    var lastname = ""
    var fbKey = ""
    var birthdayDate = ""
    
    var item : [BirthdayItem]?

    
    func SaveBirthday (item : BirthdayItem ,completion:
        @escaping (_ result: Bool) -> Void)
    {
        //ref = Database.database().reference()
        
        //let saveRef = ref.child("Birthdays").childByAutoId()
        
        //saveRef.child("Firstname").setValue()
        //saveRef.child("Lastname").setValue(newBirthday.lastname)
        //saveRef.child("BirthdayDate").setValue(newBirthday.birthdayDate)
 
        completion(true)
    }
    
    func LoadData (completion: @escaping (_ result: Bool) -> Void)
    {
        /*
        ref = Database.database().reference()
        
        ref.child("Birthdays").observeSingleEvent(of: .value) { (snapshot) in
            
            self.item = [BirthdayItem]()
            
            for birthday in snapshot.children
            {
                let loopingBirthday = birthday as! DataSnapshot
                
                let birthdayDict = loopingBirthday.value as! NSDictionary
                
                let tempBirthday = BirthdayItem()
                
                tempBirthday.fbKey = loopingBirthday.key
                
                tempBirthday.firstname = birthdayDict.value(forKey: "Firstname") as! String
                tempBirthday.lastname = birthdayDict.value(forKey: "Lastname") as! String
                tempBirthday.datePicker = birthdayDict.value(forKey: "BirthdayDate") as! String
                
                self.item?.append(tempBirthday)
            }
            
            completion(true)
            
        }
 */
    }
}
