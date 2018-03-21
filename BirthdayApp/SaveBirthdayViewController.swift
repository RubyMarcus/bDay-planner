//
//  SaveBirthdayViewController.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit

class SaveBirthdayViewController: UIViewController {

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
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        tempItem.birthdayDate = selectedDate
        
        self.BirthdayList.SaveBirthday(item: tempItem, completion: {(result: Bool) in
            
            self.navigationController?.popViewController(animated: true)
            
            self.firstnameTextField.text = ""
            self.lastnameTextField.text = ""
        })
        
        
    }

}
