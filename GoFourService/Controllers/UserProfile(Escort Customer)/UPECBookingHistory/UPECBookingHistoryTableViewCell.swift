//
//  UPECBookingHistoryTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/10/21.
//

import UIKit

class UPECBookingHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBG:UIView! {
        didSet {
            viewBG.layer.cornerRadius = 12
            viewBG.clipsToBounds = true
            //viewBG.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            viewBG.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var imgProfileImage:UIImageView! {
        didSet {
            imgProfileImage.layer.cornerRadius = 40
            imgProfileImage.clipsToBounds = true
            imgProfileImage.layer.borderWidth = 5
            imgProfileImage.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var lblName:UILabel! {
        didSet {
            lblName.text = "Allen Chandler"
        }
    }
    
    
    @IBOutlet weak var lblStatus:UILabel! {
        didSet {
            lblStatus.text = "Success"
            lblStatus.textColor = .systemGreen
        }
    }
    
    @IBOutlet weak var lblTotalTime:UILabel! {
        didSet {
            lblTotalTime.text = " Total Time: 3 Hours "
            lblTotalTime.textColor = .systemOrange
           // lblTotalTime.layer.cornerRadius = 4
            //lblTotalTime.clipsToBounds = true
            //lblTotalTime.backgroundColor = .systemGreen
        }
    }

    @IBOutlet weak var lblMainTime:UILabel! {
        didSet {
            lblMainTime.text = " Today at 3:26 PM "
            lblMainTime.textColor = .darkGray
           // lblTotalTime.layer.cornerRadius = 4
            //lblTotalTime.clipsToBounds = true
            //lblTotalTime.backgroundColor = .systemGreen
        }
    }
    
    @IBOutlet weak var btnLocation:UIButton!{
        didSet{
            btnLocation.setTitle("Charleston, VA, 2423454", for: .normal)
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
