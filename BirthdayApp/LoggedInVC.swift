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
    var testCell = BirthdayTableViewCell()
    
    @IBOutlet weak var BirthdayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(Auth.auth().currentUser == nil)
        {
            print("INTE INLOGGAD")
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            print("INLOGGAD")
            print(Auth.auth().currentUser?.uid)
            
            BirthdayList.LoadData(completion: {(result : Bool) in
                
                self.navigationItem.title = Auth.auth().currentUser?.email
                
                self.BirthdayTableView.reloadData()
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let itemcount = BirthdayList.item?.count
        {
            return itemcount
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell") as! BirthdayTableViewCell
        
        //self.testCell.CellInfo(tempItem: BirthdayList.item![indexPath.row])

        cell.nameLabel.text = "\(BirthdayList.item![indexPath.row].firstname)  \(BirthdayList.item![indexPath.row].lastname)"
        
        // Add daylabel.
        
        return cell
        
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
            
            //dismiss(animated: true, completion: nil)
            
            performSegue(withIdentifier: "login", sender: nil)
            
        }catch{
            print("There was a problem logging out")
        }
    }
}


