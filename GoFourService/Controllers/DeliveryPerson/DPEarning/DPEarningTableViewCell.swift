//
//  DPEarningTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 27/10/21.
//

import UIKit

class DPEarningTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBG:UIView! {
        didSet {
            //viewBG.layer.cornerRadius = 12
           // viewBG.clipsToBounds = true
            //viewBG.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            viewBG.backgroundColor = .white
            
            viewBG.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBG.layer.shadowOpacity = 1.0
            viewBG.layer.shadowRadius = 15.0
            viewBG.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var imgProfileImage:UIImageView! {
        didSet {
            imgProfileImage.layer.cornerRadius = 30
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
    
    
    @IBOutlet weak var lblDistance:UILabel! {
        didSet {
            lblDistance.text = "1.5 km"
            //lblStatus.textColor = .systemGreen
        }
    }
    
    @IBOutlet weak var lblLocation:UILabel! {
        didSet {
            lblLocation.text = " Dlf Mall of india, Noida"
           // lblTotalTime.textColor = .systemOrange
           // lblTotalTime.layer.cornerRadius = 4
            //lblTotalTime.clipsToBounds = true
            //lblTotalTime.backgroundColor = .systemGreen
        }
    }

    
    @IBOutlet weak var btnTime:UIButton!{
        didSet{
            btnTime.setTitle("12:10 PM", for: .normal)
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
