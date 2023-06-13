//
//  WaitingOrderPickupTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 28/10/21.
//

import UIKit
import MapKit
import CoreLocation

class WaitingOrderPickupTableViewCell: UITableViewCell {
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
