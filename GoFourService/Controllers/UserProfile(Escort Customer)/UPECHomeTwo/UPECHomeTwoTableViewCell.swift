//
//  UPECHomeTwoTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 23/10/21.
//

import UIKit
import MapKit
import CoreLocation

class UPECHomeTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var map:MKMapView!
    
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
    
    @IBOutlet weak var txtSelectHours:UITextField!{
        didSet {
            
            txtSelectHours.borderStyle = .none
            txtSelectHours.layer.masksToBounds = false
            txtSelectHours.layer.cornerRadius = 5.0;
            txtSelectHours.layer.backgroundColor = UIColor.white.cgColor
            txtSelectHours.layer.borderColor = UIColor.clear.cgColor
            txtSelectHours.layer.shadowColor = UIColor.black.cgColor
            txtSelectHours.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtSelectHours.layer.shadowOpacity = 0.2
            txtSelectHours.layer.shadowRadius = 4.0
            txtSelectHours.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var btnSelectHours:UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
