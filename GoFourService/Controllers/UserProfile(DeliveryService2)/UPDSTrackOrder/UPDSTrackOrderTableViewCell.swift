//
//  UPDSTrackOrderTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 28/10/21.
//

import UIKit
import MapKit
import CoreLocation

class UPDSTrackOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var map:MKMapView!
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            
            viewCellbg.backgroundColor = .white
        }
    }
    
    
    @IBOutlet weak var lblEstimatedTime:UILabel!
    @IBOutlet weak var lblEstimatedDistance:UILabel!
    
    
    @IBOutlet weak var lblOrder:UILabel!
   
    @IBOutlet weak var lblAmount:UILabel!
   
    @IBOutlet weak var lblAddress:UILabel!
    
    @IBOutlet weak var btnCallDriver:UIButton!{
        didSet{
            btnCallDriver.backgroundColor = NAVIGATION_COLOR
            btnCallDriver.layer.cornerRadius = 22.5
            btnCallDriver.clipsToBounds = true
        }
    }
    @IBOutlet weak var btnTextDriver:UIButton!{
        didSet{
            btnTextDriver.backgroundColor = .systemGreen
            btnTextDriver.layer.cornerRadius = 22.5
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
