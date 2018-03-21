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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func CreateBirthday(_ sender: Any) {

        guard let firstname = firstnameTextField.text, firstname != "" else {
        
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        
        }
    
    }

}
