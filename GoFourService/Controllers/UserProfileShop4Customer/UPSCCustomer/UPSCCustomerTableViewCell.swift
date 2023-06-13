//
//  UPSCCustomerTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 02/11/21.
//

import UIKit

class UPSCCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtViewFirst:UITextView!{
        didSet{
        
            txtViewFirst.layer.cornerRadius = 8
            txtViewFirst.clipsToBounds = true
            txtViewFirst.layer.borderWidth = 1
            txtViewFirst.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var txtViewSecond:UITextView!{
        didSet{
            
            txtViewSecond.layer.borderWidth = 1
            txtViewSecond.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            txtViewSecond.layer.cornerRadius = 8
            txtViewSecond.clipsToBounds = true
        }
    }
    @IBOutlet weak var btnNext:UIButton! {
        didSet {
            btnNext.setTitle("NEXT", for: .normal)
            // btnNext.layer.cornerRadius = 8
            // btnNext.clipsToBounds = true
            // btnNext.backgroundColor = NAVIGATION_COLOR
            
            btnNext.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btnNext.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btnNext.layer.shadowOpacity = 1.0
            btnNext.layer.shadowRadius = 15.0
            btnNext.layer.masksToBounds = false
            btnNext.layer.cornerRadius = 15
            btnNext.backgroundColor = NAVIGATION_COLOR

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
