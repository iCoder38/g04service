//
//  UPDSVerificationNotificationTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 20/10/21.
//

import UIKit

class UPDSVerificationNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMultiline:UILabel!{
        didSet{
"""
If your order does not have the GO4
Delivery Service seal on the
bags/containers, please immediately call
"""
        }
    }
    
    @IBOutlet weak var lblPhoneNumber:UILabel!{
        didSet{
            lblPhoneNumber.text = "901-325-2479"
        }
    }
    
    @IBOutlet weak var lblEstimatedTime:UILabel!
    @IBOutlet weak var lblDistance:UILabel!
    
    @IBOutlet weak var imgDriver:UIImageView!{
        didSet{
            
            imgDriver.layer.cornerRadius = 20
            imgDriver.clipsToBounds = true
            imgDriver.layer.borderWidth = 2
            imgDriver.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var lblRating:UILabel!
    
    @IBOutlet weak var btnCallDriver:UIButton!{
        didSet{
            btnCallDriver.setTitle("CALL DRIVER", for: .normal)
            btnCallDriver.layer.cornerRadius = 5.0
            btnCallDriver.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnTextDriver:UIButton!{
        didSet{
            btnTextDriver.setTitle("TEXT DRIVER", for: .normal)
            btnTextDriver.layer.cornerRadius = 5.0
            btnTextDriver.clipsToBounds = true
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
