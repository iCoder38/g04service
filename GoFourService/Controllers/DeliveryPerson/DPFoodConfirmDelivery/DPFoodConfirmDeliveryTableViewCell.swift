//
//  DPFoodConfirmDeliveryTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 27/10/21.
//

import UIKit
import CoreLocation
import MapKit

class DPFoodConfirmDeliveryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var map:MKMapView!
    
    @IBOutlet weak var viewCellbg:UIView!{
        didSet{
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            //viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
           viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false
            viewCellbg.backgroundColor = .white
            
           // viewCellbg.layer.borderWidth = 5
            //viewCellbg.layer.borderColor = UIColor(re
        }
    }
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var btnTextDriver:UIButton!{
        didSet{
            btnTextDriver.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var lblAdrees:UILabel!
    @IBOutlet weak var lblLandmark:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
