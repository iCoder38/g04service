//
//  UPDOInvoice.swift
//  GoFourService
//
//  Created by Dishant Rajput on 30/10/21.
//

import UIKit
import Alamofire

class UPDOInvoice: UIViewController {
    
    
    var str_invoice_driver_screen_from:String!
    
    var get_dict_invoice:NSDictionary!
    
    var str_booking_order_id:String!
    
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
                lblNavigationTitle.text = "THANK YOU"
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
        
        print("=========> RIDE HAS BEEN COMPLETED <=============")
        print(self.get_dict_invoice as Any)
        
        // print(self.str_booking_order_id as Any)
        
        self.btnPay.addTarget(self, action: #selector(push_to_payment_click_method), for: .touchUpInside)
        
        
        if self.str_invoice_driver_screen_from == "1" { // from order history page
            
            self.btnBack.isUserInteractionEnabled = true
            self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
            self.fetch_and_parse_data_from_driver_order_history()
            
        } else {
            self.fetch_data()
        }
        
    }
    
    @objc func fetch_data() {
        
        self.lblDuration.text = (self.get_dict_invoice["totalTime"] as! String)
        
        self.lblDistance.textAlignment = .center
        self.lblDistance.text = (self.get_dict_invoice["totalDistance"] as! String)+" miles"
        
        self.lblAvgSpeed.textAlignment = .center
        self.lblAvgSpeed.text = "N.A." // (self.get_dict_invoice[""] as! String)
        
        self.lblTotalFare.text = "Total fare : $"+(self.get_dict_invoice["FinalFare"] as! String)
        self.lblTotalDiscount.text = "Total discount : $"+"0.0"
        
        self.lblTripStartLocation.text = (self.get_dict_invoice["RequestPickupAddress"] as! String)
        self.lblTripEndLocation.text = (self.get_dict_invoice["RequestDropAddress"] as! String)
        
    }

    
    
    
    @objc func push_to_payment_click_method() {
        
        print("======> dishu <======")
        print(self.get_dict_invoice as Any)
        print("======> dishu <======")

        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "customer_payment_after_ride_id") as? customer_payment_after_ride
        
        push!.dict_get_total_ride_fare_details = self.get_dict_invoice
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // MARK: - FETCH DATA FROM DRIVER -
    @objc func fetch_and_parse_data_from_driver_order_history() {
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
                "bookingId"     : "\(self.get_dict_invoice["bookingId"]!)"
                
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
                                
                                self.parse_data_for_driver_from_order_history_page(dict_from_wb: dict as NSDictionary)
                                
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
    
    @objc func parse_data_for_driver_from_order_history_page(dict_from_wb:NSDictionary) {
        
        self.lblDuration.text = (dict_from_wb["totalTime"] as! String)
        
        self.lblDistance.textAlignment = .center
        self.lblDistance.text = (dict_from_wb["totalDistance"] as! String)+" miles"
        
        self.lblAvgSpeed.textAlignment = .center
        self.lblAvgSpeed.text = "N.A." // (self.get_dict_invoice[""] as! String)
        
        self.lblTotalFare.text = "Total fare : $\(dict_from_wb["FinalFare"]!)"
        
        
        
        self.lblTotalDiscount.text = "Total discount : $"+"0.0"
        
        self.lblTripStartLocation.text = (dict_from_wb["RequestPickupAddress"] as! String)
        self.lblTripEndLocation.text = (dict_from_wb["RequestDropAddress"] as! String)
        
        if "\(dict_from_wb["rideStatus"]!)" == "4" {
            
            self.navigationBar.backgroundColor = .lightGray
            self.lblNavigationTitle.text = "pending..."
            self.btnPay.setTitle("Payment is pending", for: .normal)
            self.btnPay.backgroundColor = .lightGray
            self.btnPay.isUserInteractionEnabled = false
            
        }
        
    }
    
}
