//
//  UPSCOrderDetails.swift
//  GoFourService
//
//  Created by Dishant Rajput on 03/11/21.
//

import UIKit
import Alamofire
import SDWebImage

class UPSCOrderDetails: UIViewController {
    
    var dict_get_go_4_customer:NSDictionary!
    
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
            lblNavigationTitle.text = "Details"
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var imgProfile:UIImageView! {
        didSet {
            
            imgProfile.layer.cornerRadius = 30
            imgProfile.clipsToBounds = true
            imgProfile.layer.borderWidth = 5
            imgProfile.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var btnLocation:UIButton! {
        didSet{
            btnLocation.setTitle("31, B Block, E Block, Sector 6, Noida", for: .normal)
        }
    }
    @IBOutlet weak var lblAmount:UILabel!
    
    let cellReuseIdentifier = "pOrderDetailsTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var lbl_address:UILabel! {
        didSet {
            lbl_address.textColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.tbleView.separatorColor = .clear
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        print(self.dict_get_go_4_customer as Any)
        
        self.lblName.text = (self.dict_get_go_4_customer["userName"] as! String)
        self.lblAmount.text = "$\(self.dict_get_go_4_customer["totalAmount"]!)"
        //self.btnLocation.setTitle((self.dict_get_go_4_customer["address"] as! String), for: .normal)
        self.lbl_address.text = (self.dict_get_go_4_customer["address"] as! String)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.get_to_get_request_WB(str_loader: "yes")
    }
    
    // MARK: - CONFIRM AND PICK UP FROM DRIVER SECTION -
    @objc func validate_before_confirm_pickup() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCOrderDetailsTableViewCell
        
        if cell.btn_status.titleLabel?.text != "Track your order" {
            
            let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("You picked your order ?"), style: .alert)
            let yes_picker = NewYorkButton(title: "yes, picked", style: .default) {
                _ in
                self.confirm_pickup_click_method()
            }
            
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([yes_picker , cancel])
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    
    
    @objc func confirm_pickup_click_method() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        print(self.dict_get_go_4_customer as Any)
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            print("\(self.dict_get_go_4_customer["togetRequestId"]!)")
            let parameters = [
                "action"            : "togetrequeststatusupdate",
                "driverId"          : "\(self.dict_get_go_4_customer["driverId"]!)",
                "togetRequestId"    : "\(self.dict_get_go_4_customer["togetRequestId"]!)",
                "status"            : "4"
                
                
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url, method: .post, parameters: parameters)
            
                .response { response in
                    
                    do {
                        if response.error != nil{
                            print(response.error as Any, terminator: "")
                        }
                        
                        if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{
                            
                            print(jsonDict as Any, terminator: "====> NO VALUE FOUND <====")
                            
                            // for status alert
                            var status_alert : String!
                            status_alert = (jsonDict["status"] as? String)
                            
                            // for message alert
                            var str_data_message : String!
                            str_data_message = jsonDict["msg"] as? String
                            
                            if status_alert.lowercased() == "success" {
                                
                                print("=====> yes")
                                //ERProgressHud.sharedInstance.hide()
                                
                                self.get_to_get_request_WB(str_loader: "no")
                                
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
                    }
                }
        }
    }
    
    @objc func get_to_get_request_WB(str_loader:String) {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
        if str_loader == "yes" {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        
        print(self.dict_get_go_4_customer as Any)
        
        var str_request_id:String!
        if self.dict_get_go_4_customer["togetrequestId"] == nil {
            str_request_id = "\(self.dict_get_go_4_customer["togetRequestId"]!)"
        } else {
            str_request_id = "\(self.dict_get_go_4_customer["togetrequestId"]!)"
        }
        
        let parameters = [
            "action"            : "togetdetils",
            "togetrequestId"    : String(str_request_id),
            
        ]
        
        print(parameters as Any)
        
        AF.request(application_base_url, method: .post, parameters: parameters)
        
            .response { response in
                
                do {
                    if response.error != nil{
                        print(response.error as Any, terminator: "")
                    }
                    
                    if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{
                        
                        print(jsonDict as Any, terminator: "====> NO VALUE FOUND <====")
                        
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
                            dict = jsonDict["historyList"] as! Dictionary<AnyHashable, Any>
                            
                            self.dict_get_go_4_customer = dict as NSDictionary
                            
                            self.tbleView.reloadData()
                            
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
                }
            }
        
    }
    
    @objc func track_your_order_click_method() {
        
        print("track your order click")
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track_your_order_to_get_driver_id") as? track_your_order_to_get_driver
        
        push!.dict_track_to_get_data = self.dict_get_go_4_customer
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
}

//MARK:- TABLE VIEW -
extension UPSCOrderDetails: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UPSCOrderDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPSCOrderDetailsTableViewCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        //cell.lbl
        
        cell.txtProductname.text = (self.dict_get_go_4_customer["wahtUwant"] as! String)
        cell.txtStore.text = (self.dict_get_go_4_customer["StoreCity"] as! String)
        cell.txtEstimatedPrice.text = "N.A."//(self.dict_get_go_4_customer[""] as! String)
        cell.txtTip.text = "\(self.dict_get_go_4_customer["TIP"]!)"
        cell.txtDeliveryFee.text = "\(self.dict_get_go_4_customer["deliveryFee"]!)"
        cell.txtServiceFee.text = "\(self.dict_get_go_4_customer["transactionFee"]!)"
        cell.txtSpecialNote.text = (self.dict_get_go_4_customer["notes"] as! String)
        
        if "\(self.dict_get_go_4_customer["status"]!)" == "5" {
            
            cell.btn_status.setTitle("Delivered", for: .normal)
            cell.btn_status.backgroundColor = .systemGreen
            
            self.lblNavigationTitle.text = "Delivered"
            self.navigationBar.backgroundColor = .systemGreen
            
            cell.btn_status.isUserInteractionEnabled = false
            
        } else if "\(self.dict_get_go_4_customer["status"]!)" == "1" {
            
            cell.btn_status.setTitle("Waiting for driver", for: .normal)
            cell.btn_status.backgroundColor = .systemOrange
            
        } else if "\(self.dict_get_go_4_customer["status"]!)" == "2" {
            
            cell.btn_status.setTitle("Confirm & Pickup", for: .normal)
            cell.btn_status.backgroundColor = NAVIGATION_COLOR
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                if (person["role"] as! String) == "Member" {
                    cell.btn_status.isUserInteractionEnabled = false
                } else {
                    cell.btn_status.isUserInteractionEnabled = true
                    cell.btn_status.addTarget(self, action: #selector(validate_before_confirm_pickup), for: .touchUpInside)
                }
                
            }
            
        } else if "\(self.dict_get_go_4_customer["status"]!)" == "4" {
            
            cell.btn_status.setTitle("On the way", for: .normal)
            cell.btn_status.backgroundColor = .systemYellow
            
            self.navigationBar.backgroundColor = .systemYellow
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                if (person["role"] as! String) == "Member" {
                    cell.btn_status.isUserInteractionEnabled = false
                } else {
                    
                    self.lblNavigationTitle.text = "On the Way >>"
                    cell.btn_status.setTitle("Track your order", for: .normal)
                    
                    cell.btn_status.isUserInteractionEnabled = true
                    cell.btn_status.addTarget(self, action: #selector(track_your_order_click_method), for: .touchUpInside)
                }
                
            }
            
        } else {
            
            cell.btn_status.setTitle("N.A.", for: .normal)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 850
    }
    
}

extension UPSCOrderDetails: UITableViewDelegate {
    
}

extension UPSCOrderDetails:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCOrderDetailsTableViewCell
        cell.txtViewComment.backgroundColor = UIColor.lightGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCOrderDetailsTableViewCell
        cell.txtViewComment.backgroundColor = UIColor.white
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCOrderDetailsTableViewCell
        if text == "\n" {
            cell.txtViewComment.resignFirstResponder()
            return false
        }
        return true
    }
}
