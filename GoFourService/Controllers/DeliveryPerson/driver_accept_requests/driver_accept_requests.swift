//
//  driver_accept_requests.swift
//  GoFourService
//
//  Created by Dishant Rajput on 09/09/22.
//

import UIKit
import Alamofire

class driver_accept_requests: UIViewController {

    var str_driver_status_from:String!
    
    var dict_get_full_data:NSDictionary!
    
    var str_customer_name:String!
    var str_customer_contact_number:String!
    
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
            lblNavigationTitle.text = "Driver arriving"
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var view_drop:UIView! {
        didSet {
            view_drop.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_drop.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_drop.layer.shadowOpacity = 1.0
            view_drop.layer.shadowRadius = 15.0
            view_drop.layer.masksToBounds = false
            view_drop.layer.cornerRadius = 15
            view_drop.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var lbl_customer_name:UILabel! {
        didSet {
            lbl_customer_name.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_booking_id:UILabel! {
        didSet {
            lbl_booking_id.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_drop_location:UILabel! {
        didSet {
            lbl_drop_location.textColor = .black
        }
    }
    
    @IBOutlet weak var view_user_details:UIView! {
        didSet {
            view_user_details.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_user_details.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_user_details.layer.shadowOpacity = 1.0
            view_user_details.layer.shadowRadius = 15.0
            view_user_details.layer.masksToBounds = false
            view_user_details.layer.cornerRadius = 15
            view_user_details.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var btn_contact_number:UIButton! {
        didSet {
            btn_contact_number.setTitleColor(.systemOrange, for: .normal)
        }
    }
    
    @IBOutlet weak var btn_change_status:UIButton! {
        didSet {
            btn_change_status.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_change_status.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_change_status.layer.shadowOpacity = 1.0
            btn_change_status.layer.shadowRadius = 15.0
            btn_change_status.layer.masksToBounds = false
            btn_change_status.layer.cornerRadius = 15
            btn_change_status.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var img_gif:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        print("<=======> DISHU <=======>")
        print(self.dict_get_full_data as Any)
        print("<=======> DISHU <=======>")
        
        if self.str_driver_status_from == "1" {
            
            self.btnBack.isHidden = false
            self.btnBack.tintColor = .white
            self.btnBack.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
            self.fetch_and_show_full_data_from_order_history() // from order history
            
        } else {
            
            self.btnBack.isHidden = true
            self.fetch_and_show_full_data() // from notification
            
        }
        
        
        /* FROM NOTIFICATION
         RequestDropAddress = "Palam Metro Station Palam Metro Station";
         RequestDropLatLong = "28.58831,77.084002";
         RequestPickupAddress = "Sector 10 Dwarka South West Delhi New Delhi,New Delhi,India";
         RequestPickupLatLong = "28.58723081534045,77.06061383178809";
         aps =     {
             alert =         {
                 body = "New booking request for Confir or Cancel.";
                 title = "New booking request for Confir or Cancel.";
             };
             sound = Default;
         };
         bookingId = 125;
         distance = "2.1";
         duration = "10 mins";
         "gcm.message_id" = 1662704276175194;
         "google.c.a.e" = 1;
         "google.c.fid" = "fE4FDC-9A0Amm4-gV9zZ2d";
         "google.c.sender.id" = 667327318779;
         message = "New booking request for Confir or Cancel.";
         total = "10.5";
         type = request;
         */
        
        /* FROM ORDER HISTORY
         Optional({
             AVGRating = "3.5";
             CarName = "Car-Truck & Auto\t";
             FinalFare = "";
             RequestDropAddress = "Primus Super Speciality Hospital Primus Super Speciality Hospital";
             RequestDropLatLong = "28.592896763699553,77.18140125274658";
             RequestPickupAddress = "Sector 10 Dwarka South West Delhi New Delhi,New Delhi,India";
             RequestPickupLatLong = "28.58723081534045,77.06061383178809";
             VehicleColor = "";
             bookingId = 121;
             carImage = "https://demo2.evirtualservices.co/G4delavery/img/uploads/cars/1583138572_car-trucj.png";
             contactNumber = 9865325282;
             created = "2022-09-09 00:00:00";
             email = "vee1@mailinator.com";
             estimatedPrice = "";
             fullName = vee1;
             image = "";
             latitude = "28.586790435191297";
             longitude = "77.06056999992632";
             miniumFair = 0;
             paymentMethod = "";
             paymentStatus = "";
             perMile = 5;
             rideStatus = 1;
             status = 1;
             totalAmount = "";
             transactionId = "";
             userId = 40;
             vehicleNumber = "";
             zipCode = 20101;
         })
         (lldb)
         
         
         */
        
        self.btn_change_status.addTarget(self, action: #selector(click_status_click_method), for: .touchUpInside)
    }

    @objc func fetch_and_show_full_data() {
        
        // when driver is on the way to picup the customer
        self.lbl_booking_id.text = "Booking Id : \(self.dict_get_full_data["bookingId"]!)"
        self.lbl_drop_location.text = "\(self.dict_get_full_data["RequestPickupAddress"]!)"
        
        self.lbl_customer_name.text = "customer's name show after pickup"
        
        
        self.btn_change_status.setTitle("Arrived", for: .normal)
        self.btn_change_status.backgroundColor = .systemYellow
        self.img_gif.image = UIImage.gif(name: "car_on_the_way")
        
        self.btn_contact_number.setTitle(String(self.str_customer_contact_number), for: .normal)
    }
    
    // MARK: - FETCH DATA FROM ORDER HISTORY -
    @objc func fetch_and_show_full_data_from_order_history() {
        
        self.lbl_booking_id.text = "Booking Id : \(self.dict_get_full_data["bookingId"]!)"
        self.lbl_drop_location.text = "\(self.dict_get_full_data["RequestPickupAddress"]!)"
        
        self.lbl_customer_name.text = "customer's name show after pickup"
        
        if "\(self.dict_get_full_data["rideStatus"]!)" == "1" {
            
            self.btn_change_status.setTitle("Arrived", for: .normal)
            self.btn_change_status.backgroundColor = .systemYellow
            self.img_gif.image = UIImage.gif(name: "car_on_the_way")
            
        } else if "\(self.dict_get_full_data["rideStatus"]!)" == "2" {
            
            self.navigationBar.backgroundColor = .systemOrange
            self.btn_change_status.setTitle("Start ride", for: .normal)
            
            self.img_gif.isHidden = true
            
            self.btn_change_status.backgroundColor = .systemOrange
            self.btn_change_status.setTitleColor(.white, for: .normal)
            
        }  else if "\(self.dict_get_full_data["rideStatus"]!)" == "3" {
            
            self.navigationBar.backgroundColor = .systemPurple
            self.btn_change_status.setTitle("End ride", for: .normal)
            
            self.img_gif.isHidden = true
            
            self.btn_change_status.backgroundColor = .systemPurple
            self.btn_change_status.setTitleColor(.white, for: .normal)
            
        }
       
        
        self.btn_contact_number.setTitle(String(self.str_customer_contact_number), for: .normal)
        
    }
    
    
    @objc func arrived_pop_up() {
        
        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Are you sure you arrived at customer's location ?"), style: .alert)
        
        let yes_arrived = NewYorkButton(title: "yes, arrived", style: .default) {
            _ in
            
            self.driver_arrived_at_customer_location()
        }
        
        let cencel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([yes_arrived , cencel])
        present(alert, animated: true)
        
    }
    
    // MARK: - WEBSERVICE ( DRIVER ARRIVED ) -
    @objc func driver_arrived_at_customer_location() {
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = driver_accept_request(action: "driverarrived",
                                               driverId: String(myString),
                                               bookingId: "\(self.dict_get_full_data["bookingId"]!)")
            
            print(params as Any)
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"]as Any as? String
                    
                    // var strSuccess2 : String!
                    // strSuccess2 = JSON["msg"]as Any as? String
                    
                    if strSuccess == String("success") {
                        print("yes")
                        
                        ERProgressHud.sharedInstance.hide()
                        
                        self.start_your_ride_change_status()
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    //Utils.please_check_your_internet_connection()
                    // Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                }
            }
            
        }
    }
    
    
    // MARK: - START YOUR RIDE -
    @objc func start_your_ride_change_status() {
        
        self.btn_change_status.setTitle("Start ride", for: .normal)
        self.img_gif.isHidden = true
        
        self.btn_change_status.backgroundColor = .systemOrange
        self.btn_change_status.setTitleColor(.white, for: .normal)
        
    }
    
    
    // MARK: - START YOUR RIDE POPUP -
    @objc func ride_has_beend_started_pop_up() {
        
        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Are your sure you want to start your ride ?"), style: .alert)
        
        let yes_arrived = NewYorkButton(title: "yes, start", style: .default) {
            _ in
            
            self.driver_started_ride_WB()
        }
        
        let cencel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([yes_arrived , cencel])
        present(alert, animated: true)
        
    }
    
    @objc func driver_started_ride_WB() {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Setting up your ride...")
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = driver_start_ride_params(action: "ridestart",
                                                  driverId: String(myString),
                                                  bookingId: "\(self.dict_get_full_data["bookingId"]!)",
                                                  Actual_PickupAddress: (self.dict_get_full_data["RequestPickupAddress"] as! String),
                                                  Actual_Pickup_Lat_Long: (self.dict_get_full_data["RequestPickupLatLong"] as! String))
            
            print(params as Any)
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"]as Any as? String
                    
                    // var strSuccess2 : String!
                    // strSuccess2 = JSON["msg"]as Any as? String
                    
                    if strSuccess == String("success") {
                        print("yes")
                        ERProgressHud.sharedInstance.hide()
 
                        self.end_your_ride()
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    //Utils.please_check_your_internet_connection()
                    // Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                }
            }
            
        }
    }
    
    // MARK: - END YOUR RIDE -
    @objc func end_your_ride() {
        
        // self.lbl_customer_name.text =
        self.btn_change_status.setTitle("End ride", for: .normal)
        self.img_gif.isHidden = false
        
        self.lbl_customer_name.text = String(self.str_customer_name)
        
        self.btn_change_status.backgroundColor = .lightGray
        self.btn_change_status.setTitleColor(.white, for: .normal)
        
    }
    
    
    
    // MARK: - RIDE END POPUP -
    @objc func end_your_ride_popup() {
        
        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Are your sure you want to end your ride ?"), style: .alert)
        
        let yes_arrived = NewYorkButton(title: "yes, end", style: .default) {
            _ in
            
            self.end_your_ride_WB()
            
        }
        
        let cencel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([yes_arrived , cencel])
        self.present(alert, animated: true)
        
    }
    
    // MARK: - END RIDE -
    @objc func end_your_ride_WB() {
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "ending & calculating...")
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = driver_end_ride_params(action: "rideend",
                                                driverId: String(myString),
                                                bookingId: "\(self.dict_get_full_data["bookingId"]!)",
                                                Actual_Drop_Address: (self.dict_get_full_data["RequestDropAddress"] as! String),
                                                Actual_Drop_Lat_Long: (self.dict_get_full_data["RequestDropLatLong"] as! String))
            
            print(params as Any)
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"]as Any as? String
                    
                    // var strSuccess2 : String!
                    // strSuccess2 = JSON["msg"]as Any as? String
                    
                    if strSuccess == String("success") {
                        print("yes")
                        
                        ERProgressHud.sharedInstance.hide()
                        
                        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "driver_payment_status_id")
                        self.navigationController?.pushViewController(push, animated: true)
                        
                        print("======> RIDE END SUCCESSFULLY <========")
                        
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    //Utils.please_check_your_internet_connection()
                    // Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                }
            }
            
        }
    }
    
    
    
    
    
    // MARK: - CHANGE STATUS CLICK -
    @objc func click_status_click_method() {
        
        if self.btn_change_status.titleLabel?.text == "Arrived" {
            
            self.arrived_pop_up()
            
        } else if self.btn_change_status.titleLabel?.text == "Start ride" {
            
            self.ride_has_beend_started_pop_up()
            
        } else if self.btn_change_status.titleLabel?.text == "End ride" {
            
            self.end_your_ride_popup()
            
        }
        
    }
}
