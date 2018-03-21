//
//  DetailViewController.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    
    
    var tempItem = BirthdayItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameTextField.text = tempItem.firstname
        lastnameTextField.text = tempItem.lastname
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EditTrue(_ sender: Any) {
        
        EditButton.isHidden = true
        
        SaveButton.isHidden = false
        
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        
        self.tempItem.SaveBirthday(item: tempItem, completion: {(result: Bool) in
            
            self.EditButton.isHidden = false
            
            self.SaveButton.isHidden = true
        })
    }
    
    
    
    
    
    
    
    
}
