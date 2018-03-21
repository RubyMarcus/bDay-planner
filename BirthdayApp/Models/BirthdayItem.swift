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
}
