//
//  booking_history_details.swift
//  GoFourService
//
//  Created by Dishant Rajput on 07/09/22.
//

import UIKit
import SDWebImage
import Alamofire

class booking_history_details: UIViewController {

    var str_booking_order_id:String!
    
    var get_dict_booking_details:NSDictionary!
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var navigationBar:UIView! {
        didSet {
            navigationBar.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var sideMenu:UIButton! {
        didSet {
            sideMenu.tintColor = NAVIGATION_BACK_COLOR
        }
    }
    
    @IBOutlet weak var lblNavigationTitle:UILabel! {
        didSet {
            lblNavigationTitle.text = booking_order_details
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var lblTripStartTime:UILabel!
    @IBOutlet weak var lblTripEndTime:UILabel!
    
    @IBOutlet weak var lblTripStartLocation:UILabel!
    @IBOutlet weak var lblTripEndLocation:UILabel!
    
    @IBOutlet weak var btnPay:UIButton! {
        didSet {
            btnPay.backgroundColor = NAVIGATION_COLOR
           //btnPay.addTarget(self, action: #selector(btnPayClickMethod), for: .touchUpInside)
            btnPay.setTitle("PAY NOW", for: .normal)
        }
    }
    @IBOutlet weak var lblAvgSpeed: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var lblTotalFare: UILabel!
    
    
    @IBOutlet weak var lblTotalDiscount: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // self.tble_view.separatorColor = .clear
        
        self.sideMenu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        // print(self.get_dict_booking_details as Any)
        
        self.booking_details_wb()
        
    }

    @objc func booking_details_wb() {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            
            let parameters = [
                "action"        : "bookingdetail",
                "userId"        : String(myString),
                "bookingId"     : String(self.str_booking_order_id),
                
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url, method: .post, parameters: parameters)
            
                .response { response in
                    
                    do {
                        if response.error != nil{
                            print(response.error as Any, terminator: "")
                        }
                        
                        if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject] {
                            
                             print(jsonDict as Any, terminator: "====> ALL VALUEs HERE <====")
                            
                            // for status alert
                            var status_alert : String!
                            status_alert = (jsonDict["status"] as? String)
                            
                            // for message alert
                            var str_data_message : String!
                            str_data_message = jsonDict["msg"] as? String
                            
                            if status_alert.lowercased() == "success" {
                                
                                print("=====> yes")
                                ERProgressHud.sharedInstance.hide()
                                
                                var dict: Dictionary<AnyHashable, Any>
                                dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                                
                                self.get_dict_booking_details = dict as NSDictionary
                                
                                //var ar : NSArray!
                                //ar = (dict["foodDetailsNew"] as! Array<Any>) as NSArray
                                
                                self.parse_booking_details()
                                
                            } else {
                                
                                print("=====> no")
                                ERProgressHud.sharedInstance.hide()
                                
                                let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                                let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                                alert.addButtons([cancel])
                                self.present(alert, animated: true)
                                
                            }
                            
                        } else {
                            
                            ERProgressHud.sharedInstance.hide()
                            self.please_check_your_internet_connection()
                            
                            return
                        }
                        
                    } catch _ {
                        print("Exception!")
                        ERProgressHud.sharedInstance.hide()
                        // print(response.error)
                        // print(response.error?.localizedDescription)
                    }
                }
        }
    }
    
    @objc func parse_booking_details() {
        
        self.btnPay.addTarget(self, action: #selector(btn_pay_click_method), for: .touchUpInside)
        
        self.lblDuration.text = (self.get_dict_booking_details["totalTime"] as! String)
        self.lblDistance.text = (self.get_dict_booking_details["totalDistance"] as! String)
        self.lblAvgSpeed.text = "N.A."// (self.get_dict_booking_details[""] as! String)
        
        self.lblTotalFare.text = "Total fare : $\(self.get_dict_booking_details["FinalFare"]!)"
        self.lblTotalDiscount.text = "Total discount : $0.0"
        
        self.lblTripStartLocation.text = (self.get_dict_booking_details["RequestPickupAddress"] as! String)
        self.lblTripEndLocation.text = (self.get_dict_booking_details["RequestDropAddress"] as! String)
        
        if "\(self.get_dict_booking_details["status"]!)" == "1" {
            
            self.btnPay.setTitle("Send Review", for: .normal)
            
        } else if "\(self.get_dict_booking_details["status"]!)" == "7" {
            
            self.btnPay.setTitle("Cancelled", for: .normal)
            self.btnPay.backgroundColor =  .systemRed
            
        } else {
            
            self.btnPay.setTitle("Pay now", for: .normal)
            self.btnPay.backgroundColor =  .systemOrange
            
        }
            
    }
    
    @objc func btn_pay_click_method() {
        
        if "\(self.get_dict_booking_details["status"]!)" == "2" {
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPECSuccessRateDriver_id") as? UPECSuccessRateDriver

            push!.dict_get_driver_details_for_review = self.get_dict_booking_details
            //push!.str_get_driver_id = "\(self.get_dict_booking_details["driverId"]!)"
            
            self.navigationController?.pushViewController(push!, animated: true)
            
            //
            
        } else if "\(self.get_dict_booking_details["status"]!)" == "1" {
            
        } else {
            
        }
        
    }
    
}
