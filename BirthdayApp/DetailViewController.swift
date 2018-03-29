//
//  DetailViewController.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var txtAddText: UITextField!
    @IBOutlet weak var txtList: UITextView!
    
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var EditButton: UIButton!

    @IBOutlet var commentTextField: UITextView!
    
    
    var tempItem = BirthdayItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        firstnameTextField.text = tempItem.firstname
        lastnameTextField.text = tempItem.lastname
        commentTextField.text = tempItem.comment
        
        
        let dateString = tempItem.birthdayDate
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let date = df.date(from: dateString)
        if let unwrappedDate = date {
            datePicker.setDate(unwrappedDate, animated: false)
        }

        //Get days between two dates.
        
        // Do any additional setup after loading the view.
    }


    
    
    
        @IBAction func EditTrue(_ sender: Any) {
        
        
        if(EditButton.titleLabel?.text == "Edit")
        {
            
            EditButton.setTitle("Save", for: .normal)
            
            firstnameTextField.isUserInteractionEnabled = true
            lastnameTextField.isUserInteractionEnabled = true
            datePicker.isUserInteractionEnabled = true
            commentTextField.isUserInteractionEnabled = true
            
        }
        else if(EditButton.titleLabel?.text == "Save")
        {
            
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
            
            tempItem.firstname = firstnameTextField.text!
            tempItem.lastname = lastnameTextField.text!
            
            datePicker.datePickerMode = UIDatePickerMode.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            
            tempItem.birthdayDate = selectedDate
            
            tempItem.comment = commentTextField.text
            
            
            tempItem.SaveBirthday(item: tempItem, completion: {(result: Bool) in
                
                self.EditButton.setTitle("Edit", for: .normal)
                
                self.firstnameTextField.isUserInteractionEnabled = false
                self.lastnameTextField.isUserInteractionEnabled = false
                self.datePicker.isUserInteractionEnabled = false
                self.commentTextField.isUserInteractionEnabled = false
                
                //Change in notifications aswell
                
                self.navigationController?.popViewController(animated: true)
            })
            
        }
    }
    
}


