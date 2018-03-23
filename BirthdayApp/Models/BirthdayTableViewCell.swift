//
//  BirthdayTableViewCell.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-03-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit

class BirthdayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    /*
    func CellInfo(tempItem : BirthdayItem)
    {
        nameLabel.text = "\(tempItem.firstname) \(tempItem.lastname)"
        
        //Convert to days....
        
        //dayLabel.text =
        
        
    }
    */

}

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}


