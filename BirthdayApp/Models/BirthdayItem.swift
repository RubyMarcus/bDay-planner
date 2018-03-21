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
    
    
    /*
    var ref: DatabaseReference!
    
    var firstname = ""
    var lastname = ""
    var fbKey = ""
    var birthdayDate = ""
    
    
    
    func SaveBirthday (datePicker : UIDatePicker, firstname : String, lastname : String, completion:
        @escaping (_ result: Bool) -> Void)
    {
        ref = Database.database().reference()
        
        let newBirthday = BirthdayItem()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        newBirthday.firstname = firstname
        newBirthday.lastname = lastname
        newBirthday.birthdayDate = selectedDate
        
        let saveRef = ref.child("Birthdays").childByAutoId()
        
        saveRef.child("Firstname").setValue(newBirthday.firstname)
        saveRef.child("Lastname").setValue(newBirthday.lastname)
        saveRef.child("BirthdayDate").setValue(newBirthday.birthdayDate)
        
        completion(true)
    }
 */
}
