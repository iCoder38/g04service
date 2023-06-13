//
//  to_get_address.swift
//  GoFourService
//
//  Created by Dishant Rajput on 20/09/22.
//

import UIKit
import Alamofire

// MARK:- LOCATION -
import CoreLocation

class to_get_address: UIViewController , UITextFieldDelegate , CLLocationManagerDelegate {
    
    var dict_get_full_data_of_to_get_for_payment:NSDictionary!
    
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
    
    var ar_data : NSArray!
    
    
    var arr_mut_added_address_list:NSMutableArray! = []
    
    var str_show_proceed:String! = "0"
    
    var str_i_am_from:String!
    
    var arr_mut_card_list:NSMutableArray! = []
    
    var str_final_amount:String!
    var arr_mut_get_product_details_address:NSMutableArray! = []
    
    var dict_get_clicked_address:NSDictionary!
    
    var str_mark:String! = "0"
    
    
    var dict_get_price_taxes_details_in_address:NSDictionary!
    var str_get_special_not_from_payment_in_address:String!
    var str_total_amount_after_tax_in_address:String!
    var arr_mut_food_item_in_address:NSMutableArray! = []
    
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var btnSaveAddress:UIButton! {
        didSet {
            btnSaveAddress.backgroundColor = button_dark
            btnSaveAddress.setTitle("Save & Continue", for: .normal)
            btnSaveAddress.tintColor = .black
            btnSaveAddress.setTitleColor(.white, for: .normal)
            btnSaveAddress.layer.cornerRadius = 28
            btnSaveAddress.clipsToBounds = true
            
            btnSaveAddress.layer.borderColor = button_light.cgColor
            btnSaveAddress.layer.borderWidth = 1
            
        }
    }
    
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
            lblNavigationTitle.text = "Address"
            lblNavigationTitle.textColor = .white
        }
    }
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var tablView:UITableView! {
        didSet {
            // tablView.delegate = self
            // tablView.dataSource = self
            tablView.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.manage_profile(self.btnBack)
        
        // self.list_of_all_address_WB(str_loader: "yes")
        
        self.btnSaveAddress.addTarget(self, action: #selector(validationBeforeAddorEditNewAddress), for: .touchUpInside)
        
        print("=======> DISHANT RAJPUT <==========")
        print(self.dict_get_full_data_of_to_get_for_payment as Any)
//        print(self.str_get_special_not_from_payment_in_address as Any)
//        print(self.str_total_amount_after_tax_in_address as Any)
//        print(self.arr_mut_food_item_in_address as Any)
        print("=======> DISHANT RAJPUT <==========")
        
        
        
        
        self.iAmHereForLocationPermission()
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
                
                self.tablView.delegate = self
                self.tablView.dataSource = self
                self.tablView.reloadData()
                
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
            
            
            // let indexPath = IndexPath.init(row: 0, section: 0)
            // let cell = self.tablView.cellForRow(at: indexPath) as! address_table_cell
            
            
            
            //MARK:- STOP LOCATION -
            self.locationManager.stopUpdatingLocation()

            self.tablView.delegate = self
            self.tablView.dataSource = self
            self.tablView.reloadData()
            
            // self.findMyStateTaxWB()
        }
    }
    
    
    // MARK:- VALIDATINO BEFORE SUBMIT -
    @objc func validationBeforeAddorEditNewAddress() {
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! to_get_address_table_cell
        
        if cell.txtName.text == "" {
            
            self.errorPopUp(strTitle: "First Name", strMessage: "First name field")
            
        } else if cell.txtPhone.text == "" {
            
            self.errorPopUp(strTitle: "Mobile Number", strMessage: "Mobile Number field")
            
        } else if cell.txtAddress.text == "" {
            
            self.errorPopUp(strTitle: "Address Line", strMessage: "Address Line field")
            
        } else if cell.txtCity.text == "" {
            
            self.errorPopUp(strTitle: "City", strMessage: "City field")
            
        } else if cell.txtZipcode.text == "" {
            
            self.errorPopUp(strTitle: "Pincode", strMessage: "Zip Code")
            
        } else if cell.txtState.text == "" {
            
            self.errorPopUp(strTitle: "State", strMessage: "State field")
            
        } else if cell.txtLandmark.text == "" {
            
            self.errorPopUp(strTitle: "Landmark", strMessage: "Landmark")
            
        } else {
            
            /*if editOrAdd == "editAddress" {
             
             self.editAddress()
             } else {
             
             self.addNewAddress()
             }*/
            
            self.add_address_WB()
            
            
        }
        
    }
    
    // MARK: - WEBSERVICE ( ADD ADDRESS ) -
    @objc func add_address_WB() {
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! to_get_address_table_cell
        
        let custom_dict = [
            "name"          : (cell.txtName.text!),
            "address"       : (cell.txtAddress.text!),
            "city"          : (cell.txtCity.text!),
            "state"         : (cell.txtState.text!),
            "zipcode"       : (cell.txtZipcode.text!),
            "latitude"      : (self.strSaveLatitude!),
            "longitude"     : (self.strSaveLongitude!),
            "phone"         : (cell.txtPhone.text!),
            "landmark"      : (cell.txtLandmark.text!),
            "mark"          : (self.str_mark!),
            "special_notes" : String(cell.txtViewAntSpecialNote.text!),
            // dict_get_full_data_of_to_get_for_payment
            "estimate_price"        : (self.dict_get_full_data_of_to_get_for_payment["estimate_price"] as! String),
            "fare_time_estimate"    : (self.dict_get_full_data_of_to_get_for_payment["fare_time_estimate"] as! String),
            "mileage_fee"           : (self.dict_get_full_data_of_to_get_for_payment["mileage_fee"] as! String),
            "store_you_live"        : (self.dict_get_full_data_of_to_get_for_payment["store_you_live"] as! String),
            "tax_estimate"          : (self.dict_get_full_data_of_to_get_for_payment["tax_estimate"] as! String),
            "tip_amount"            : (self.dict_get_full_data_of_to_get_for_payment["tip_amount"] as! String),
            "total_amount"          : (self.dict_get_full_data_of_to_get_for_payment["total_amount"] as! String),
            "what_would_you_like"   : (self.dict_get_full_data_of_to_get_for_payment["what_would_you_like"] as! String),
            
        ] as? [String:String]
        
        // print(custom_dict as Any)
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "to_get_payment_id") as? to_get_payment
        
        push!.dict_get_full_address_and_data = custom_dict as NSDictionary?

        self.navigationController?.pushViewController(push!, animated: true)
                
    }
    
    @objc func errorPopUp(strTitle:String,strMessage:String) {
        
        let alert = UIAlertController(title: String(strTitle), message: String(strMessage)+" should not be empty", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - WEBSERVICE ( LIST OF ALL ADDRESS ) -
    @objc func list_of_all_address_WB(str_loader:String) {
        self.arr_mut_added_address_list.removeAllObjects()
        
        self.view.endEditing(true)
        
        if str_loader == "yes" {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = address_list_params(action: "addresslist",
                                             userId: String(myString))
            
            
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
                    strSuccess = (JSON["status"]as Any as? String)?.lowercased()
                    print(strSuccess as Any)
                    if strSuccess == String("success") {
                        print("yes")
                        
                        ERProgressHud.sharedInstance.hide()
                        
                        
                        self.ar_data = (JSON["data"] as! Array<Any>) as NSArray
                        
                        for indexx in 0..<self.ar_data.count {
                         
                            let item = self.ar_data[indexx] as? [String:Any]
                            
                            let custom_dict = ["City":(item!["City"] as! String),
                                               "Zipcode":(item!["Zipcode"] as! String),
                                               "address":(item!["address"] as! String),
                                               "addressId":"\(item!["addressId"]!)",
                                               "company":(item!["company"] as! String),
                                               "country":(item!["country"] as! String),
                                               "deliveryType":(item!["deliveryType"] as! String),
                                               "firstName":(item!["firstName"] as! String),
                                               "lastName":(item!["lastName"] as! String),
                                               "mobile":(item!["mobile"] as! String),
                                               "state":(item!["state"] as! String),
                                               "status":"no"]
                         
                         self.arr_mut_added_address_list.add(custom_dict)
                         
                         }
                        
                        // self.arr_mut_added_address_list.addObjects(from: ar as! [Any])
                        
                        self.tablView.delegate = self
                        self.tablView.dataSource = self
                        self.tablView.reloadData()
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"]as Any as? String
                        
                        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String(strSuccess2), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    self.please_check_your_internet_connection()
                    
                }
            }
        }
    }
    
    
    
    @objc func after_add_address_success() {
        
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! to_get_address_table_cell
        
        cell.txtName.text      = ""
        cell.txtAddress.text       = ""
        cell.txtCity.text           = ""
        cell.txtState.text          = ""
        cell.txtLandmark.text   = ""
        cell.txtViewAntSpecialNote.text = ""
        
        self.tablView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        // ERProgressHud.sharedInstance.hide()
        
        self.list_of_all_address_WB(str_loader: "no")
        
    }
    
    // MARK: - PUSH ( PROCEED ) -
    @objc func proceed_click_method() {
        
        // check if any card is already add
        // self.card_list_WB()
        
        
        
    }
    
    // MARK: - WEBSERVICE ( CARD LIST ) -
    @objc func card_list_WB() {
        self.arr_mut_card_list.removeAllObjects()
        
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = card_list_params(action: "cardlist",
                                          userId: String(myString),
                                          pageNo: "")
            
            
            print(params as Any)
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    // print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = (JSON["status"]as Any as? String)?.lowercased()
                    print(strSuccess as Any)
                    if strSuccess == String("success") {
                        print("yes")
                        
                        ERProgressHud.sharedInstance.hide()
                        
                        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "all_card_list_id") as? all_card_list
                        
                        push!.get_full_address = self.dict_get_clicked_address
                        push!.get_final_price_in_all_cards_screen = String(self.str_final_amount)
                        push!.get_products_list_in_all_cards_screen = self.arr_mut_get_product_details_address
                        push!.payment_type = String(self.str_i_am_from)
                        
                        self.navigationController?.pushViewController(push!, animated: true)
                        */
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"]as Any as? String
                        
                        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String(strSuccess2), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    self.please_check_your_internet_connection()
                    
                }
            }
        }
    }
    
    
    @objc func home_click_method() {
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! to_get_address_table_cell
        
        /*
         var str_btn_home:String! = "0"
         var str_btn_work:String! = "0"
         var str_btn_other:String! = "0"
         */
        
        self.str_mark = "Home"
        cell.btn_home.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        cell.btn_work.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        cell.btn_other.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        
    }
    
    @objc func work_click_method() {
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! to_get_address_table_cell
        
        self.str_mark = "Work"
        cell.btn_home.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        cell.btn_work.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        cell.btn_other.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        
    }
    
    @objc func other_click_method() {
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = self.tablView.cellForRow(at: indexPath) as! to_get_address_table_cell
        
        self.str_mark = "Other"
        cell.btn_home.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        cell.btn_work.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        cell.btn_other.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}


//MARK: - TABLE VIEW -
extension to_get_address: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:to_get_address_table_cell = tableView.dequeueReusableCell(withIdentifier: "to_get_address_table_cell_one") as! to_get_address_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
            /*cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()*/
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell:to_get_address_table_cell = tableView.dequeueReusableCell(withIdentifier: "to_get_address_table_cell_three") as! to_get_address_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
                        
            cell.btn_proceed.addTarget(self, action: #selector(proceed_click_method), for: .touchUpInside)
            
            return cell
            
        } else {
            
            let cell:to_get_address_table_cell = tableView.dequeueReusableCell(withIdentifier: "to_get_address_table_cell_two") as! to_get_address_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            /*@IBOutlet weak var btn_home:UIButton!
            @IBOutlet weak var btn_work:UIButton!
            @IBOutlet weak var btn_other:UIButton!*/
            
            cell.txtAddress.text = String(self.strSaveLocalAddress)+" "+String(self.strSaveLocality)+" "+String(self.strSaveLocalAddressMini)+","+String(self.strSaveStateName)+","+String(self.strSaveCountryName)
            
            cell.txtCity.text = String(self.strSaveStateName)
            cell.txtState.text = String(self.strSaveStateName)
            cell.txtZipcode.text = String(self.strSaveZipcodeName)
            
            cell.txtName.delegate = self
            cell.txtAddress.delegate = self
            cell.txtCity.delegate = self
            cell.txtState.delegate = self
            cell.txtZipcode.delegate = self
            cell.txtPhone.delegate = self
            cell.txtLandmark.delegate = self
            
            cell.txtViewAntSpecialNote.text = ""
            
            cell.btn_home.addTarget(self, action: #selector(home_click_method), for: .touchUpInside)
            cell.btn_work.addTarget(self, action: #selector(work_click_method), for: .touchUpInside)
            cell.btn_other.addTarget(self, action: #selector(other_click_method), for: .touchUpInside)

            return cell
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "browse_product_images_id")
         self.navigationController?.pushViewController(push, animated: true)*/
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.arr_mut_added_address_list.count == 0 {
            
            if indexPath.row == 0 {
                return 0
            } else if indexPath.row == 1 {
                return 0
            } else {
                return 1400
            }
            
        } else {
            
            if self.str_show_proceed == "0" {
                
                if indexPath.row == 0 {
                    return 240
                } else if indexPath.row == 1 {
                    return 0
                } else {
                    return 1400
                }
                
            } else {
                
                if indexPath.row == 0 {
                    return 240
                } else if indexPath.row == 1 {
                    return 72
                } else {
                    return 1400
                }
                
            }
            
        }
        
    }
    
}

//MARK:- COLLECTION VIEW -
extension to_get_address: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arr_mut_added_address_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "address_collection_cell", for: indexPath as IndexPath) as! address_collection_cell
        
        cell.backgroundColor  = .clear
        
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .white
        
        let item = self.arr_mut_added_address_list[indexPath.row] as? [String:Any]
        cell.lbl_address_user_name.text = (item!["firstName"] as! String)+" "+(item!["lastName"] as! String)
        cell.lbl_full_address.text = (item!["address"] as! String)+", "+(item!["City"] as! String)+", "+(item!["state"] as! String)+", "+(item!["country"] as! String)+" - "+(item!["Zipcode"] as! String)
        
        if (item!["status"] as! String) == "yes" {
            cell.btn_check_mark.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            cell.btn_check_mark.setImage(UIImage(systemName: ""), for: .normal)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var sizes: CGSize
        let result = UIScreen.main.bounds.size
        NSLog("%f",result.height)
        sizes = CGSize(width: 188, height: 160)
        
        /*if result.height == 844 {
         
         print("i am iPhone 12")
         sizes = CGSize(width: 116, height: 130)
         } else if result.height == 812 {
         
         print("i am iPhone 12 mini")
         sizes = CGSize(width: 110, height: 130)
         } else {
         
         sizes = CGSize(width: 120, height: 130)
         }*/
        
        return sizes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.arr_mut_added_address_list[indexPath.row] as? [String:Any]
        
        self.arr_mut_added_address_list.removeAllObjects()
        
        for indexx in 0..<self.ar_data.count {
            
            let item_e = self.ar_data[indexx] as? [String:Any]
            
            let custom_dict = ["City":(item_e!["City"] as! String),
                               "Zipcode":(item_e!["Zipcode"] as! String),
                               "address":(item_e!["address"] as! String),
                               "addressId":"\(item_e!["addressId"]!)",
                               "company":(item_e!["company"] as! String),
                               "country":(item_e!["country"] as! String),
                               "deliveryType":(item_e!["deliveryType"] as! String),
                               "firstName":(item_e!["firstName"] as! String),
                               "lastName":(item_e!["lastName"] as! String),
                               "mobile":(item_e!["mobile"] as! String),
                               "state":(item_e!["state"] as! String),
                               "status":"no"]
            
            self.arr_mut_added_address_list.add(custom_dict)
            
        }
        
        self.arr_mut_added_address_list.removeObject(at: indexPath.row)
        
        let custom_dict = ["City":(item!["City"] as! String),
                           "Zipcode":(item!["Zipcode"] as! String),
                           "address":(item!["address"] as! String),
                           "addressId":"\(item!["addressId"]!)",
                           "company":(item!["company"] as! String),
                           "country":(item!["country"] as! String),
                           "deliveryType":(item!["deliveryType"] as! String),
                           "firstName":(item!["firstName"] as! String),
                           "lastName":(item!["lastName"] as! String),
                           "mobile":(item!["mobile"] as! String),
                           "state":(item!["state"] as! String),
                           "status":"yes"]
        
        self.arr_mut_added_address_list.insert(custom_dict, at: indexPath.row)
        
        self.dict_get_clicked_address = item as NSDictionary?
        // print(self.dict_get_clicked_address as Any)
        
        self.str_show_proceed = "1"
        
        self.tablView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class to_get_address_table_cell:UITableViewCell {
    
    
    // collection view
    @IBOutlet weak var collectionView:UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            // collectionView.dataSource = self
            // collectionView.delegate = self
        }
    }
    
    @IBOutlet weak var txtName:UITextField! {
        didSet {
            txtName.borderStyle = .none
            txtName.layer.masksToBounds = false
            txtName.layer.cornerRadius = 5.0;
            txtName.layer.backgroundColor = UIColor.white.cgColor
            txtName.layer.borderColor = UIColor.clear.cgColor
            txtName.layer.shadowColor = UIColor.black.cgColor
            txtName.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtName.layer.shadowOpacity = 0.2
            txtName.layer.shadowRadius = 4.0
            txtName.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtAddress:UITextField! {
        didSet {
            txtAddress.borderStyle = .none
            txtAddress.layer.masksToBounds = false
            txtAddress.layer.cornerRadius = 5.0;
            txtAddress.layer.backgroundColor = UIColor.white.cgColor
            txtAddress.layer.borderColor = UIColor.clear.cgColor
            txtAddress.layer.shadowColor = UIColor.black.cgColor
            txtAddress.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtAddress.layer.shadowOpacity = 0.2
            txtAddress.layer.shadowRadius = 4.0
            txtAddress.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtCity:UITextField! {
        didSet {
            txtCity.borderStyle = .none
            txtCity.layer.masksToBounds = false
            txtCity.layer.cornerRadius = 5.0;
            txtCity.layer.backgroundColor = UIColor.white.cgColor
            txtCity.layer.borderColor = UIColor.clear.cgColor
            txtCity.layer.shadowColor = UIColor.black.cgColor
            txtCity.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtCity.layer.shadowOpacity = 0.2
            txtCity.layer.shadowRadius = 4.0
            txtCity.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtState:UITextField! {
        didSet {
            txtState.borderStyle = .none
            txtState.layer.masksToBounds = false
            txtState.layer.cornerRadius = 5.0;
            txtState.layer.backgroundColor = UIColor.white.cgColor
            txtState.layer.borderColor = UIColor.clear.cgColor
            txtState.layer.shadowColor = UIColor.black.cgColor
            txtState.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtState.layer.shadowOpacity = 0.2
            txtState.layer.shadowRadius = 4.0
            txtState.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtZipcode:UITextField! {
        didSet {
            txtZipcode.borderStyle = .none
            txtZipcode.layer.masksToBounds = false
            txtZipcode.layer.cornerRadius = 5.0;
            txtZipcode.layer.backgroundColor = UIColor.white.cgColor
            txtZipcode.layer.borderColor = UIColor.clear.cgColor
            txtZipcode.layer.shadowColor = UIColor.black.cgColor
            txtZipcode.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtZipcode.layer.shadowOpacity = 0.2
            txtZipcode.layer.shadowRadius = 4.0
            txtZipcode.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtPhone:UITextField! {
        didSet {
            txtPhone.borderStyle = .none
            txtPhone.layer.masksToBounds = false
            txtPhone.layer.cornerRadius = 5.0;
            txtPhone.layer.backgroundColor = UIColor.white.cgColor
            txtPhone.layer.borderColor = UIColor.clear.cgColor
            txtPhone.layer.shadowColor = UIColor.black.cgColor
            txtPhone.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtPhone.layer.shadowOpacity = 0.2
            txtPhone.layer.shadowRadius = 4.0
            txtPhone.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtLandmark:UITextField! {
        didSet {
            txtLandmark.borderStyle = .none
            txtLandmark.layer.masksToBounds = false
            txtLandmark.layer.cornerRadius = 5.0;
            txtLandmark.layer.backgroundColor = UIColor.white.cgColor
            txtLandmark.layer.borderColor = UIColor.clear.cgColor
            txtLandmark.layer.shadowColor = UIColor.black.cgColor
            txtLandmark.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtLandmark.layer.shadowOpacity = 0.2
            txtLandmark.layer.shadowRadius = 4.0
            txtLandmark.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtViewAntSpecialNote:UITextView! {
        didSet {
            txtViewAntSpecialNote.text = ""
            txtViewAntSpecialNote.layer.borderColor = UIColor.black.cgColor
            txtViewAntSpecialNote.layer.borderWidth = 0.8
        }
    }
    
    
    
    @IBOutlet weak var btn_proceed:UIButton! {
        didSet {
            btn_proceed.backgroundColor = button_light
            btn_proceed.setTitle("Proceed", for: .normal)
            btn_proceed.tintColor = .black
            btn_proceed.setImage(UIImage(systemName: "arrow.right"), for: .normal)
            btn_proceed.setTitleColor(.black, for: .normal)
            btn_proceed.layer.cornerRadius = 28
            btn_proceed.clipsToBounds = true
            
            btn_proceed.layer.borderColor = button_dark.cgColor
            btn_proceed.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var btn_home:UIButton! {
        didSet {
            btn_home.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    @IBOutlet weak var btn_work:UIButton! {
        didSet {
            btn_work.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    @IBOutlet weak var btn_other:UIButton! {
        didSet {
            btn_other.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
}

class to_get_address_collection_cell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_address_user_name:UILabel! {
        didSet {
            lbl_address_user_name.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_full_address:UILabel! {
        didSet {
            lbl_full_address.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_check_mark:UIButton! {
        didSet {
            btn_check_mark.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
    
}
