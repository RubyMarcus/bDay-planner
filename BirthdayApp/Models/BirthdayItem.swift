//
//  BirthdayItem.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class BirthdayItem {
    
    var ref: DatabaseReference!
    
    var firstname = ""
    var lastname = ""
    var fbKey = ""
    var birthdayDate = ""
    var comment = ""
    var numberRow = 0
    
    var item : [BirthdayItem]?

    func deleteItem (item : BirthdayItem, completion: @escaping (_ result: Bool) -> Void)
    {
        
        ref = Database.database().reference()
        
        var deleteRef = ref.child("Users").child(Auth.auth().currentUser!.uid)
        
        deleteRef.child("Birthdays").observeSingleEvent(of: .value) { (snapshot) in
            
            self.item = [BirthdayItem]()
            
            for birthday in snapshot.children
            {
                let loopingBirthday = birthday as! DataSnapshot
                
                print(loopingBirthday.key)
                
                if(item.fbKey == loopingBirthday.key)
                {
                    print("test")
                    
                    deleteRef = deleteRef.ref.child("Birthdays")
                    
                    deleteRef.ref.child(item.fbKey).removeValue()
                    
                    completion(true)
                }
            }
        }
    }
    
    func SaveBirthday (item : BirthdayItem ,completion:
        @escaping (_ result: Bool) -> Void)
    {
        ref = Database.database().reference()
        
        let key = ""
        
        print(item.fbKey)
        
        if key == item.fbKey
        {
            var saveRef = ref.child("Users").child(Auth.auth().currentUser!.uid)
            
            saveRef = saveRef.ref.child("Birthdays")
            
            saveRef = saveRef.childByAutoId()
            
            saveRef.child("Firstname").setValue(item.firstname)
            saveRef.child("Lastname").setValue(item.lastname)
            saveRef.child("BirthdayDate").setValue(item.birthdayDate)
            saveRef.child("Comment").setValue(item.comment)
            
        } else {
            
            var saveRef = ref.child("Users").child(Auth.auth().currentUser!.uid)
            
            saveRef = saveRef.child("Birthdays").child(item.fbKey)
            
            saveRef.child("Firstname").setValue(item.firstname)
            saveRef.child("Lastname").setValue(item.lastname)
            saveRef.child("BirthdayDate").setValue(item.birthdayDate)
            saveRef.child("Comment").setValue(item.comment)
            
        }
        
 
        completion(true)
    }
    
    func LoadData (completion: @escaping (_ result: Bool) -> Void)
    {
        
        ref = Database.database().reference()
        
        var fbLoadfrom = ref.child("Users")
        fbLoadfrom = fbLoadfrom.child(Auth.auth().currentUser!.uid)
        
        fbLoadfrom.child("Birthdays").observeSingleEvent(of: .value) { (snapshot) in
            
            self.item = [BirthdayItem]()
            
            for birthday in snapshot.children
            {
                let loopingBirthday = birthday as! DataSnapshot
                
                let birthdayDict = loopingBirthday.value as! NSDictionary
                
                let tempBirthday = BirthdayItem()
                
                tempBirthday.fbKey = loopingBirthday.key
                
                tempBirthday.firstname = birthdayDict.value(forKey: "Firstname") as! String
                tempBirthday.lastname = birthdayDict.value(forKey: "Lastname") as! String
                tempBirthday.birthdayDate = birthdayDict.value(forKey: "BirthdayDate") as! String
                tempBirthday.comment = birthdayDict.value(forKey: "Comment") as! String
                
                self.item?.append(tempBirthday)
            }
            
            completion(true)
            
        }
 
    }
}
