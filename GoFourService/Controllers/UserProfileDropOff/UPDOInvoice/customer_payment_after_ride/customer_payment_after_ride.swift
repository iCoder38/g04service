//
//  customer_payment_after_ride.swift
//  GoFourService
//
//  Created by Dishant Rajput on 09/09/22.
//

import UIKit
import Alamofire
import SwiftyJSON

// MARK:- LOCATION -
import CoreLocation

class customer_payment_after_ride: UIViewController  , UITextFieldDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    // MARK:- SAVE LOCATION STRING -
    var strSaveLatitude:String!
    var strSaveLongitude:String!
    var strSaveCountryName:String!
    var strSaveLocalAddress:String!
    var strSaveLocality:String!
    var strSaveLocalAddressMini:String!
    var strSaveStateName:String!
    var strSaveZipcodeName:String!
    
    var dict_get_total_ride_fare_details:NSDictionary!
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var navigationBar:UIView! {
        didSet {
            navigationBar.backgroundColor = NAVIGATION_COLOR
            navigationBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            navigationBar.layer.shadowOpacity = 1.0
            navigationBar.layer.shadowRadius = 15.0
            navigationBar.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var btnBack:UIButton! {
        didSet {
            btnBack.tintColor = .white
            btnBack.isHidden = false
        }
    }
    
    @IBOutlet weak var lblNavigationTitle:UILabel! {
        didSet {
            lblNavigationTitle.text = "Card"
            lblNavigationTitle.textColor = .white
        }
    }
    
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
            txt_search.keyboardType = .default
            
            txt_search.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_search.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_search.layer.shadowOpacity = 1.0
            txt_search.layer.shadowRadius = 15.0
            txt_search.layer.masksToBounds = false
            txt_search.layer.cornerRadius = 6
            txt_search.backgroundColor = .white
            txt_search.setLeftPaddingPoints(20)
            
            txt_search.attributedPlaceholder =
            NSAttributedString(string: "search product here...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            
        }
    }
    
    @IBOutlet weak var btn_current_location:UIButton! {
        didSet {
            btn_current_location.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_current_location.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_current_location.layer.shadowOpacity = 1.0
            btn_current_location.layer.shadowRadius = 15.0
            btn_current_location.layer.masksToBounds = false
            btn_current_location.layer.cornerRadius = 6
            btn_current_location.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var tablView:UITableView! {
        didSet {
            tablView.delegate = self
            tablView.dataSource = self
            tablView.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        print("=====> RAJPUTANA <=====")
        
        print(self.dict_get_total_ride_fare_details as Any)
        
        /*
         DriverImage = "";
         FinalFare = 4;
         RequestDropAddress = "Restaurants Restaurants";
         RequestDropLatLong = "28.585298959102992,77.07052409648895";
         RequestPickupAddress = "Sector 10 Dwarka South West Delhi New Delhi,New Delhi,India";
         RequestPickupLatLong = "28.587240557551798,77.06061606153447";
         VehicleColor = Silver;
         aps =     {
             alert =         {
                 body = "driverp1 has completed your ride.";
                 title = "driverp1 has completed your ride.";
             };
             sound = Default;
         };
         bookingId = 131;
         driverContact = 9865324421;
         driverId = 25;
         driverLatitude = "28.587205743903827";
         driverName = driverp1;
         driverlongitude = "77.06060733213882";
         "gcm.message_id" = 1662714599073460;
         "google.c.a.e" = 1;
         "google.c.fid" = fvYNXvoUbEyZh3rVGJjqBn;
         "google.c.sender.id" = 667327318779;
         message = "driverp1 has completed your ride.";
         rating = "3.59";
         totalDistance = "0.8";
         totalTime = "6 mins";
         type = rideend;
         vehicleNumber = 51yywu;
         */
        
        print("=====> RAJPUTANA <=====")
        
        // self.iAmHereForLocationPermission()
    }
    
    @objc func iAmHereForLocationPermission() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                self.strSaveLatitude = "0"
                self.strSaveLongitude = "0"
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                
            @unknown default:
                break
            }
            
        }
    }
    
    // MARK:- GET CUSTOMER LOCATION -
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! PDBagPurchaseTableCell
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.fetchCityAndCountry { city, country, zipcode,localAddress,localAddressMini,locality, error in
            guard let city = city, let country = country,let zipcode = zipcode,let localAddress = localAddress,let localAddressMini = localAddressMini,let locality = locality, error == nil else { return }
            
            self.strSaveCountryName     = country
            self.strSaveStateName       = city
            self.strSaveZipcodeName     = zipcode
            
            self.strSaveLocalAddress     = localAddress
            self.strSaveLocality         = locality
            self.strSaveLocalAddressMini = localAddressMini
            
            //print(self.strSaveLocality+" "+self.strSaveLocalAddress+" "+self.strSaveLocalAddressMini)
            
            let doubleLat = locValue.latitude
            let doubleStringLat = String(doubleLat)
            
            let doubleLong = locValue.longitude
            let doubleStringLong = String(doubleLong)
            
            self.strSaveLatitude = String(doubleStringLat)
            self.strSaveLongitude = String(doubleStringLong)
            
            print("local address ==> "+localAddress as Any) // south west delhi
            print("local address mini ==> "+localAddressMini as Any) // new delhi
            print("locality ==> "+locality as Any) // sector 10 dwarka
            
            print(self.strSaveCountryName as Any) // india
            print(self.strSaveStateName as Any) // new delhi
            print(self.strSaveZipcodeName as Any) // 110075
            
            //MARK:- STOP LOCATION -
            self.locationManager.stopUpdatingLocation()
            
            // self.findMyStateTaxWB()
        }
    }
    
    // MARK: - KEYBOARD DISMISS WHEN CLICK ON RETURN BUTTON -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! customer_payment_after_ride_table_cell
        
        
        
        if textField == cell.txt_card_number {
            
            print(textField.text as Any)
            
            let first_2_digits = String(cell.txt_card_number.text!.prefix(2))
            let first_1_digits = String(cell.txt_card_number.text!.prefix(1))
            
            if first_2_digits.count == 2 {
                
                if first_2_digits == "34" || first_2_digits == "37" { // AMEX
                    
                    cell.lbl_card_name.text = "amex"
                    
                } else {
                    
                    if first_1_digits == "4" {
                        
                        cell.lbl_card_name.text = "visa"
                        
                    } else if first_1_digits == "5" {
                        
                        cell.lbl_card_name.text = "master"
                        
                    } else if first_1_digits == "6" {
                        
                        cell.lbl_card_name.text = "discover"
                        
                    } else {
                        cell.lbl_card_name.text = "invalid"
                    }
                    
                }
                
            } else {
                
                // when digit is one in card number text field
                cell.lbl_card_name.text = ""
                cell.txt_cvv.text = ""
                
            }
            
            
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! customer_payment_after_ride_table_cell
        
        if textField == cell.txt_card_number {
            
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            
            if cell.lbl_card_name.text == "amex" {
                return count <= 15
            } else {
                return count <= 16
            }
            
        } else if textField == cell.txt_cvv {
            
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            
            if cell.lbl_card_name.text == "amex" {
                return count <= 4
            } else {
                return count <= 3
            }
            
        } else if textField == cell.txt_exp_month {
            
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            
            return count <= 2
            
            
        } else if textField == cell.txt_exp_year {
            
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            
            return count <= 4
            
            
        }
        
        return false
        
    }
    
    // MARK: - ADD NEW CARD -
    @objc func add_new_card_WB() {
        
    }
    
    
    // MARK: - PUSH ( PROCEED PAYMENT ) -
    @objc func proceed_payment_click_method() {
        
        self.update_payment_after_ride_WB()
        
    }
    
    @objc func update_payment_after_ride_WB() {
         let indexPath = IndexPath.init(row: 0, section: 0)
         let cell = self.tablView.cellForRow(at: indexPath) as! customer_payment_after_ride_table_cell
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let last4 = String(cell.txt_card_number.text!.suffix(4))
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let parameters = [
                "action"        : "updatepayment",
                "userId"        : String(myString),
                "bookingId"     : "\(self.dict_get_total_ride_fare_details["bookingId"]!)",
                "totalAmount"   : "\(self.dict_get_total_ride_fare_details["FinalFare"]!)",
                "paymentMethod" : String("Card"),
                "transactionId" : String("dummy_transaction_id"),
                "cardNo"        : String(last4)
                
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url, method: .post, parameters: parameters)
            
                .response { response in
                    
                    do {
                        if response.error != nil{
                            print(response.error as Any, terminator: "")
                        }
                        
                        if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{
                            
                            print(jsonDict as Any, terminator: "")
                            
                            // for status alert
                            var status_alert : String!
                            status_alert = (jsonDict["status"] as? String)
                            
                            // for message alert
                            var str_data_message : String!
                            str_data_message = jsonDict["msg"] as? String
                            
                            if status_alert.lowercased() == "success" {
                                
                                print("=====> yes")
                                 ERProgressHud.sharedInstance.hide()
                                
                                /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "success_ride_status_id")
                                 self.navigationController?.pushViewController(push, animated: true)*/
                                
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
                        
                        print("Exception! 2.0")
                        ERProgressHud.sharedInstance.hide()
                        self.please_check_your_internet_connection()
                        
                    }
                }
        }
        
    }
    
}

//MARK:- TABLE VIEW -
extension customer_payment_after_ride: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:customer_payment_after_ride_table_cell = tableView.dequeueReusableCell(withIdentifier: "customer_payment_after_ride_table_cell") as! customer_payment_after_ride_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.accessoryType = .none
        
        // cell.txt_name_on_card.delegate = self
        cell.txt_card_number.delegate = self
        cell.txt_exp_month.delegate = self
        cell.txt_exp_year.delegate = self
        cell.txt_cvv.delegate = self
        // cell.txt_nick_name.delegate = self
        // update_payment_food
        cell.btn_proceed.addTarget(self, action: #selector(proceed_payment_click_method), for: .touchUpInside)
        
        // cell.btn_save_card_button.addTarget(self, action: #selector(save_card_button_click_method), for: .touchUpInside)
        
        cell.txt_card_number.addTarget(self, action: #selector(payment_screen.textFieldDidChange(_:)), for: .editingChanged)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "browse_product_category_id")
         self.navigationController?.pushViewController(push, animated: true)*/
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 900
    }
    
}

class customer_payment_after_ride_table_cell:UITableViewCell {
    
    @IBOutlet weak var lbl_card_name:UILabel! {
        didSet {
            lbl_card_name.textColor = .black
            lbl_card_name.text = ""
        }
    }
    
    @IBOutlet weak var txt_name_on_card:UITextField! {
        didSet {
            txt_name_on_card.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_name_on_card.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_name_on_card.layer.shadowOpacity = 1.0
            txt_name_on_card.layer.shadowRadius = 15.0
            txt_name_on_card.layer.masksToBounds = false
            txt_name_on_card.layer.cornerRadius = 14
            txt_name_on_card.backgroundColor = .white
            txt_name_on_card.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txt_card_number:UITextField! {
        didSet {
            txt_card_number.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_card_number.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_card_number.layer.shadowOpacity = 1.0
            txt_card_number.layer.shadowRadius = 15.0
            txt_card_number.layer.masksToBounds = false
            txt_card_number.layer.cornerRadius = 14
            txt_card_number.backgroundColor = .white
            txt_card_number.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txt_exp_month:UITextField! {
        didSet {
            txt_exp_month.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_exp_month.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_exp_month.layer.shadowOpacity = 1.0
            txt_exp_month.layer.shadowRadius = 15.0
            txt_exp_month.layer.masksToBounds = false
            txt_exp_month.layer.cornerRadius = 14
            txt_exp_month.backgroundColor = .white
            txt_exp_month.setLeftPaddingPoints(20)
            txt_exp_month.keyboardType = .numberPad
        }
    }
    
    @IBOutlet weak var txt_exp_year:UITextField! {
        didSet {
            txt_exp_year.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_exp_year.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_exp_year.layer.shadowOpacity = 1.0
            txt_exp_year.layer.shadowRadius = 15.0
            txt_exp_year.layer.masksToBounds = false
            txt_exp_year.layer.cornerRadius = 14
            txt_exp_year.backgroundColor = .white
            txt_exp_year.setLeftPaddingPoints(20)
            txt_exp_year.keyboardType = .numberPad
        }
    }
    
    @IBOutlet weak var txt_cvv:UITextField! {
        didSet {
            txt_cvv.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_cvv.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_cvv.layer.shadowOpacity = 1.0
            txt_cvv.layer.shadowRadius = 15.0
            txt_cvv.layer.masksToBounds = false
            txt_cvv.layer.cornerRadius = 14
            txt_cvv.backgroundColor = .white
            txt_cvv.setLeftPaddingPoints(20)
            txt_cvv.keyboardType = .numberPad
        }
    }
    
    /*@IBOutlet weak var txt_nick_name:UITextField! {
     didSet {
     txt_nick_name.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
     txt_nick_name.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
     txt_nick_name.layer.shadowOpacity = 1.0
     txt_nick_name.layer.shadowRadius = 15.0
     txt_nick_name.layer.masksToBounds = false
     txt_nick_name.layer.cornerRadius = 14
     txt_nick_name.backgroundColor = .white
     txt_nick_name.setLeftPaddingPoints(20)
     }
     }*/
    
    @IBOutlet weak var btn_proceed:UIButton! {
        didSet {
            btn_proceed.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_proceed.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_proceed.layer.shadowOpacity = 1.0
            btn_proceed.layer.shadowRadius = 15.0
            btn_proceed.layer.masksToBounds = false
            btn_proceed.layer.cornerRadius = 14
            btn_proceed.backgroundColor = button_dark
            btn_proceed.setTitleColor(.white, for: .normal)
        }
    }
    
    /*@IBOutlet weak var btn_save_card_button:UIButton! {
     didSet {
     btn_save_card_button.tag = 0
     btn_save_card_button.setImage(UIImage(named: "un_check_mark"), for: .normal)
     }
     }*/
    
}
