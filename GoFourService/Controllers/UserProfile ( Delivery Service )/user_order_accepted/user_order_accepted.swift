//
//  user_order_accepted.swift
//  GoFourService
//
//  Created by Apple on 19/07/22.
//

import UIKit
import Alamofire
import SwiftGifOrigin
import MapKit
import SDWebImage

class user_order_accepted: UIViewController {
    
    var str_get_status:String!
    var dict_get_accepted_booking_details:NSDictionary!
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = NAVIGATION_BACK_COLOR
                btnBack.isHidden = true
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = "On the way"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
           
    let cellReuseIdentifier = "ConfirmBookingTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        print("==========> accepted details <==============")
        print(self.dict_get_accepted_booking_details as Any)
        
        if self.str_get_status == "1" {
            self.lblNavigationTitle.text = "On the way"
        } else if self.str_get_status == "2" {
            self.lblNavigationTitle.text = "Arrived"
        } else {
            self.lblNavigationTitle.text = "Ride is ON"
        }
        
    }
    
    @objc func car_info_click_method() {
        
        let alert = NewYorkAlertController(title: String("Car info"), message: String("strSuccess2"), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        present(alert, animated: true)
        
    }

    @objc func callMethodClick() {
        if let url = URL(string: "tel://\(self.dict_get_accepted_booking_details["driverContact"] as! String)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

//MARK:- TABLE VIEW -
extension user_order_accepted: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:user_order_accepted_table_cell = tableView.dequeueReusableCell(withIdentifier: "user_order_accepted_table_cell") as! user_order_accepted_table_cell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lblStartingLocation.text = (self.dict_get_accepted_booking_details["RequestPickupAddress"] as! String)
        cell.lblEndLocation.text = (self.dict_get_accepted_booking_details["RequestDropAddress"] as! String)
        
        cell.lblEstimateTime.text = "N.A."//(self.dict_get_accepted_booking_details["N.A."] as! String)
        
        cell.lblRating.text = "\(self.dict_get_accepted_booking_details["rating"]!)"
        cell.lbl_booking_id.text = "Booking id: \(self.dict_get_accepted_booking_details["bookingId"]!)"
        
        
        cell.imgDriver.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        cell.imgDriver.sd_setImage(with: URL(string: (self.dict_get_accepted_booking_details["DriverImage"] as! String)), placeholderImage: UIImage(named: "logo"))
        // cell.imgDriver.image = UIImage(named: "david")
    
        
        if self.str_get_status == "1" {
            cell.img_car_move.image = UIImage.gif(name: "car_on_the_way")
        } else if self.str_get_status == "2" {
            cell.img_car_move.image = UIImage.gif(name: "car_reached")
        } else {
            cell.img_car_move.image = UIImage.gif(name: "car_on_the_way")
        }
        
        
        cell.lblDriverName.text = (self.dict_get_accepted_booking_details["driverName"] as! String)
        cell.lblVehicalNumberModel.text = (self.dict_get_accepted_booking_details["vehicleNumber"] as! String)+"("+(self.dict_get_accepted_booking_details["VehicleColor"] as! String)+")"
        
        cell.btn_car_info.isHidden = true
        cell.btn_car_info.addTarget(self, action: #selector(car_info_click_method), for: .touchUpInside)
        
        cell.btnCallDriver.addTarget(self, action: #selector(callMethodClick), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
}

class user_order_accepted_table_cell: UITableViewCell {
    
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
    
    @IBOutlet weak var btnBookingConfirmed:UIButton!{
        didSet{
            btnBookingConfirmed.setTitle("", for: .normal)
            btnBookingConfirmed.isEnabled = false
        }
    }
    
    @IBOutlet weak var lblVehicalNumberModel:UILabel!
    @IBOutlet weak var lblEstimateTime:UILabel! {
        didSet {
            
            lblEstimateTime.layer.cornerRadius = 5.0
            lblEstimateTime.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var img_car_move:UIImageView!
    
    @IBOutlet weak var lblDriverName:UILabel! {
        didSet {
            btnCallDriver.setTitleColor(.black, for: .normal)
        }
    }
   
    
    @IBOutlet weak var btnCallDriver:UIButton! {
        didSet {
            btnCallDriver.setTitleColor(.darkGray, for: .normal)
        }
    }
    
    @IBOutlet weak var btn_cancel_ride:UIButton! {
        didSet {
            btn_cancel_ride.setTitleColor(.systemRed, for: .normal)
        }
    }
    
    @IBOutlet weak var imgDriver:UIImageView!{
        didSet {
            imgDriver.layer.cornerRadius = 20
            imgDriver.clipsToBounds = true
            imgDriver.layer.borderWidth = 9
            imgDriver.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var btn_car_info:UIButton!
    
    @IBOutlet weak var lblRating:UILabel!
    
    @IBOutlet weak var lbl_booking_id:UILabel! {
        didSet {
            lbl_booking_id.textColor = .black
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
