//
//  UPDSDashboard.swift
//  GoFourService
//
//  Created by Apple on 31/12/20.
//

import UIKit
import Alamofire

class UPDSDashboard: UIViewController {

    var str_device_token_is:String! = "N.A."
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = NAVIGATION_BACK_COLOR
                btnBack.setImage(UIImage(named: "menu"), for: .normal)
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = DASHBOARD_PAGE_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    var str_profile_select:String! = "0"
    
    @IBOutlet weak var viewOne:UIView! {
        didSet {
            viewOne.backgroundColor = UIColor(red: 22.0/255.0, green: 63.0/255.0, blue: 168.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var viewTwo:UIView! {
        didSet {
            viewTwo.backgroundColor = .clear
        }
    }
    
    
    @IBOutlet weak var btnGo4Shopper:UIButton!
    
    
    @IBOutlet weak var viewDeliver:UIView! {
        didSet {
            viewDeliver.layer.cornerRadius = 4
            viewDeliver.clipsToBounds = true
            viewDeliver.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var viewCurbside:UIView! {
        didSet {
            viewCurbside.layer.cornerRadius = 4
            viewCurbside.clipsToBounds = true
            viewCurbside.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var viewGoFourShopper:UIView! {
        didSet {
            viewGoFourShopper.layer.cornerRadius = 4
            viewGoFourShopper.clipsToBounds = true
            viewGoFourShopper.backgroundColor = .white
        }
    }
    
    
    @IBOutlet weak var btnCheckUncheck:UIButton! {
        didSet {
            btnCheckUncheck.tintColor = .black
        }
    }
    
    @IBOutlet weak var lbl_go_4_shopper:UILabel! {
        didSet {
            lbl_go_4_shopper.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_curbside_check_uncheck:UIButton! {
        didSet {
            btn_curbside_check_uncheck.tintColor = .black
        }
    }
    
    
    @IBOutlet weak var btnContinue:UIButton! {
        didSet {
            btnContinue.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var imgProfilePicture:UIImageView! {
        didSet {
            imgProfilePicture.layer.cornerRadius = 75
            imgProfilePicture.clipsToBounds = true
            imgProfilePicture.layer.borderWidth = 9
            imgProfilePicture.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var lbl_user_name:UILabel! {
        didSet {
            lbl_user_name.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_customer_id:UILabel! {
        didSet {
            lbl_customer_id.textColor = .darkGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.side_bar_menu_click(self.btnBack)
        
        self.btnCheckUncheck.tag = 0
        self.btnCheckUncheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        
        self.btn_curbside_check_uncheck.tag = 0
        self.btn_curbside_check_uncheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        
        self.btnCheckUncheck.addTarget(self, action: #selector(checkUncheckClickMethod), for: .touchUpInside)
        self.btn_curbside_check_uncheck.addTarget(self, action: #selector(customer_curbside_click_method), for: .touchUpInside)
        
        self.btnContinue.addTarget(self, action: #selector(continueClickMethod), for: .touchUpInside)
        
        self.btnGo4Shopper.addTarget(self, action: #selector(go4ShopperClickMethod), for: .touchUpInside)
        
        self.fetch_login_user_data()
    }
    
    
    
    @objc func fetch_login_user_data() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if (person["role"] as! String) == "Member" {
                
                self.lbl_user_name.text = (person["username"] as! String)
                self.lbl_customer_id.text = "Customer ID: #"
                
                self.edit_device_token_for_customer()
            }
            
            
        }
        
    }
    
    
    
    @objc func checkUncheckClickMethod() {
        
        if self.btnCheckUncheck.tag == 0 {
            
            self.str_profile_select = "1"
            self.btnCheckUncheck.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.btnCheckUncheck.tag = 1
            
        } else {
            
            self.str_profile_select = "0"
            self.btnCheckUncheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.btnCheckUncheck.tag = 0
            
        }
        
    }
    
    // MARK: - CUSTOMER - CURBSIDE -
    @objc func customer_curbside_click_method() {
        
        if self.btnCheckUncheck.tag == 0 {
            
            self.str_profile_select = "2"
            self.btn_curbside_check_uncheck.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.btn_curbside_check_uncheck.tag = 1
            
        } else {
            
            self.str_profile_select = "0"
            self.btn_curbside_check_uncheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.btn_curbside_check_uncheck.tag = 0
            
        }
        
    }
    
    // MARK: - CONTINUE CLICK METHOD -
    @objc func continueClickMethod() {
        
        if self.str_profile_select == "1" {
        
            let settingsVCId = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSOrderFoodId") as? UPDSOrderFood
            self.navigationController?.pushViewController(settingsVCId!, animated: true)
            
        } else if self.str_profile_select == "2" {
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDOHomeId")
            self.navigationController?.pushViewController(push, animated: true)
             
        } else if self.str_profile_select == "DOC" {
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPSCCustomer")
            self.navigationController?.pushViewController(push, animated: true)
            
        } else if self.str_profile_select == "EC" {
            
        } else if self.str_profile_select == "S4C" {
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please select atleast one option."), style: .alert)
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        }
        
    }
    
    @objc func go4ShopperClickMethod() {
        
        let dummyList = ["Drop off Customer", "Escort Customer", "Shop 4 Customer"]
        
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) {[] (selctedText, atIndex) in
            // TODO: Your implementation for selection
            // self?.outputLabel.text = selctedText + " selcted at \(atIndex)"
            
            print(selctedText+" \(atIndex)")
            
            if "\(atIndex)" == "0" {
                
                self.str_profile_select = "DOC"
                self.lbl_go_4_shopper.text = "G04 Shopper ( Drop off Customer )"
                
            } else if "\(atIndex)" == "1" {
                
                self.str_profile_select = "EC"
                self.lbl_go_4_shopper.text = "G04 Shopper ( Escort Customer )"
                
            } else if "\(atIndex)" == "2" {
                
                self.str_profile_select = "S4C"
                self.lbl_go_4_shopper.text = "G04 Shopper ( Shop4 Customer )"
                
            } else {
                
                self.str_profile_select = "N.A."
                
            }
            
            
        }
        
    }
    
    
    @objc func edit_device_token_for_customer() {
        print("edit profile call")
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        // 13.708233729327171 100.51003435701973
        
        
        // key_my_device_token
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
        let defaults = UserDefaults.standard
        if let myString = defaults.string(forKey: "key_my_device_token") {
            self.str_device_token_is = myString
            
        }
        else {
            self.str_device_token_is = "111111111111111111111"
        }
        
        let parameters = [
            "action"        : "editprofile",
            "userId"        : String(myString),
            "deviceToken"   : String(self.str_device_token_is)
            
        ]
        
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
                        
                        var dict: Dictionary<AnyHashable, Any>
                        dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(dict, forKey: str_save_login_user_data)
                        
                        
                    } else {
                        
                        print("=====> no")
                        ERProgressHud.sharedInstance.hide()
                        
                        let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
                        
                    }
                    
                } else {
                    
                    self.please_check_your_internet_connection()
                    
                    return
                }
                
            } catch _ {
                print("Exception!")
            }
        }}
    }
}
