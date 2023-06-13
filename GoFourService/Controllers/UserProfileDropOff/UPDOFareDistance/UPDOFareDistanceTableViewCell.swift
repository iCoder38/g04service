//
//  UPDOFareDistanceTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 29/10/21.
//

import UIKit
import CoreLocation
import MapKit

class UPDOFareDistanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapView:MKMapView!
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false
            viewCellbg.backgroundColor = .white
            
    
        }
    }
    
    @IBOutlet weak var btnStarting:UIButton!{
        didSet{
            btnStarting.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var btnEnding:UIButton!{
        didSet{
            btnEnding.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var lblStartingLocation:UILabel!
    @IBOutlet weak var lblEndLocation:UILabel!
    
    @IBOutlet weak var lbl_duration:UILabel! {
        didSet {
            lbl_duration.textColor = .black
        }
    }
    @IBOutlet weak var lbl_distance:UILabel! {
        didSet {
            lbl_distance.textColor = .black
        }
    }
    
    @IBOutlet weak var viewCellbgDown:UIView! {
        didSet {
            viewCellbgDown.layer.cornerRadius = 8
            viewCellbgDown.clipsToBounds = true
            viewCellbgDown.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbgDown.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbgDown.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbgDown.layer.shadowOpacity = 1.0
            viewCellbgDown.layer.shadowRadius = 15.0
            viewCellbgDown.layer.masksToBounds = false
            viewCellbgDown.backgroundColor = .white
            
        }
    }
    
    @IBOutlet weak var lblTotalPayableAmount:UILabel!
    
    @IBOutlet weak var btnFareEstimate:UIButton!
    @IBOutlet weak var btnPromocode:UIButton!
    @IBOutlet weak var btnSelectPaymentMethod:UIButton! {
        didSet {
            // btnSelectPaymentMethod.setTitle(" Payment method", for: <#T##UIControl.State#>)
        }
    }

    @IBOutlet weak var lbl_payment_type:UILabel! {
        didSet {
            lbl_payment_type.text = "Card"
            lbl_payment_type.textColor = .black
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
