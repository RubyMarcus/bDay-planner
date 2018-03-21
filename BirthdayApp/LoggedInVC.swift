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

    
    //Tableview functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell")
        
        cell?.textLabel?.text = "Test"
        
        return cell!
        
    }
    
    
    
    
    
    // Account function
    
    @IBAction func logoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            
            dismiss(animated: true, completion: nil)
            
        }catch{
            print("There was a problem logging out")
        }
    }
}
