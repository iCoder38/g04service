//
//  DPJobHistoryTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 27/10/21.
//

import UIKit

class DPJobHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBG:UIView! {
        didSet {
            viewBG.layer.cornerRadius = 12
            viewBG.clipsToBounds = true
            //viewBG.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            viewBG.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var lblPrice: UILabel!{
        didSet{
            lblPrice.text = "$222.96"
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
    
    @IBOutlet weak var lblRestaurantName:UILabel! {
        didSet {
            lblRestaurantName.text = "Oven Story"
        }
    }
    
    
    
    @IBOutlet weak var btnLocation:UIButton!{
        didSet{
            btnLocation.setTitle("Charleston, VA, 2423454", for: .normal)
        }
    }
    
    @IBOutlet weak var btnTimeDate:UIButton!{
        didSet{
            btnTimeDate.setTitle("12 Sep 2021 | 09:40 AM", for: .normal)
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
