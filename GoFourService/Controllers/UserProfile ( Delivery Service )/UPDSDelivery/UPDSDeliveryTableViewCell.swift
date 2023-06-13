//
//  UPDSDeliveryTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 21/10/21.
//

import UIKit
import MapKit
import CoreLocation

class UPDSDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblBillAmount: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblLandmark: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var btnMarkDeliverd: UIButton!
    
    @IBOutlet weak var viewBgFirst:UIView!{
        didSet{
            viewBgFirst.layer.cornerRadius = 8
            viewBgFirst.clipsToBounds = true
            
            viewBgFirst.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBgFirst.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBgFirst.layer.shadowOpacity = 1.0
            viewBgFirst.layer.shadowRadius = 15.0
            viewBgFirst.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var viewBgSecond:UIView!{
        didSet{
            viewBgSecond.layer.cornerRadius = 8
            viewBgSecond.clipsToBounds = true
            
            viewBgSecond.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBgSecond.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBgSecond.layer.shadowOpacity = 1.0
            viewBgSecond.layer.shadowRadius = 15.0
            viewBgSecond.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var lblSpecialComments: UILabel!
    
    @IBOutlet weak var viewBgThird:UIView!{
        didSet{
            viewBgThird.layer.cornerRadius = 8
            viewBgThird.clipsToBounds = true
            viewBgThird.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBgThird.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBgThird.layer.shadowOpacity = 1.0
            viewBgThird.layer.shadowRadius = 15.0
            viewBgThird.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var txtViewComment: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
