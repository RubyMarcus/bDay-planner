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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell")
        
        cell?.textLabel?.text = "Test"
        
        return cell!
        
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
            
            dismiss(animated: true, completion: nil)
            
        }catch{
            print("There was a problem logging out")
        }
    }
}
