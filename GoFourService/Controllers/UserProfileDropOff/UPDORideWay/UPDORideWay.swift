//
//  UPDORideWay.swift
//  GoFourService
//
//  Created by Dishant Rajput on 30/10/21.
//

import UIKit
import CoreLocation
import MapKit

class UPDORideWay: UIViewController {
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = NAVIGATION_BACK_COLOR
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = "HOME"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
    
    ///
    
    @IBOutlet weak var map:MKMapView!
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            /*viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false*/
            viewCellbg.backgroundColor = .white
            
    
        }
    }
    
    @IBOutlet weak var imgProfile:UIImageView!{
        didSet{
            
            imgProfile.layer.cornerRadius = 30
            imgProfile.clipsToBounds = true
            imgProfile.layer.borderWidth = 5
            imgProfile.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var btnLocation:UIButton!{
        didSet{
            btnLocation.setTitle("Location", for: .normal)
            btnLocation.isEnabled = false
        }
    }
    @IBOutlet weak var btnCall:UIButton!{
        didSet{
            btnCall.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var btnAccurateLocation:UIButton!{
        didSet{
            btnAccurateLocation.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblCarNameNum:UILabel!
    @IBOutlet weak var lblRating:UILabel!
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

}
