//
//  Login.swift
//  GoFourService
//
//  Created by Apple on 31/12/20.
//

import UIKit
 import SDWebImage
// import SwiftGifOrigin

import Alamofire

class Login: UIViewController , UITextFieldDelegate {
    
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
            lblNavigationTitle.text = LOGIN_PAGE_NAVIGATION_TITLE
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "loginTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
            tbleView.showsVerticalScrollIndicator = false
            tbleView.showsHorizontalScrollIndicator = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        /*NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)*/
        
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! PDCompleteAddressDetailsTableCell
        
        // self.login_WB()
        
        
        // self.edit_WB()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        self.scroll_to_top(table_view: self.tbleView)
        
        return true
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validpassword(mypassword : String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        // let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: mypassword)
        
    }
    
    
    // MARK: - ( WEBSERVICE )LOGIN -
    @objc func login_WB() {
        self.view.endEditing(true)
        
        self.scroll_to_top(table_view: self.tbleView)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! LoginTableCell
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"        : "login",
            "email"         : String(cell.txtEmailAddress.text!),
            "password"      : String(cell.txtPassword.text!),
            "device"        : "iOS",
            "deviceToken"   : "",
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
                        
                        // push
                        if (dict["role"] as! String) == "Member" {
                            self.push_to_customer_dashboard()
                        } else if (dict["role"] as! String) == "Driver" {
                            
                            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DPDashboardId")
                            self.navigationController?.pushViewController(push, animated: true)
                            
                        }
                        
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
        }
    }
    
//    // MARK: - ( WEBSERVICE ) EDIT -
//    @objc func edit_WB() {
//        self.view.endEditing(true)
//        
//        self.scroll_to_top(table_view: self.tbleView)
//        
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tbleView.cellForRow(at: indexPath) as! LoginTableCell
//        
//        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
//        
//        if Login.IsInternetAvailable() == false {
//            self.please_check_your_internet_connection()
//            return
//        }
//        
//        // 13.708233729327171 100.51003435701973
//        
//        let parameters = [
//            "action"        : "editprofile",
//            "userId"        : "25",
//            "latitude"      : "13.708233729327171",
//            "longitude"     : "100.51003435701973",
//            "deviceToken"   : "dlwSIS_rME5_gwagsvKUMC:APA91bEW2rLBvFnoP24vSOygb1ctqCTDmWISLiYxYetkRXGV_5e0oBnkJfdrD0V2-MfClIdiY9SKxj7iXlr0teZD3B3VzbP1TPl1Qr4JjVDolXOfbZCRS8_qw43VcYjkXQK3lG29Xig3"
//            // "deviceToken"   : "",
//        ]
//        
//        AF.request(application_base_url, method: .post, parameters: parameters)
//        
//        .response { response in
//            
//            do {
//                if response.error != nil{
//                    print(response.error as Any, terminator: "")
//                }
//                
//                if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{
//                    
//                    print(jsonDict as Any, terminator: "")
//
//                    // for status alert
//                    var status_alert : String!
//                    status_alert = (jsonDict["status"] as? String)
//                    
//                    // for message alert
//                    var str_data_message : String!
//                    str_data_message = jsonDict["msg"] as? String
//                    
//                    if status_alert.lowercased() == "success" {
//                        
//                        print("=====> yes")
//                        ERProgressHud.sharedInstance.hide()
//                        
//                        
//                        
//                    } else {
//                        
//                        print("=====> no")
//                        ERProgressHud.sharedInstance.hide()
//                        
//                        let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
//                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
//                        alert.addButtons([cancel])
//                        self.present(alert, animated: true)
//                        
//                    }
//                    
//                } else {
//                    
//                    self.please_check_your_internet_connection()
//                    
//                    return
//                }
//                
//            } catch _ {
//                print("Exception!")
//            }
//        }
//    }

    
    @objc func push_to_customer_dashboard () {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSDashboardId") as? UPDSDashboard
        self.navigationController?.pushViewController(push!, animated: true)

    }
    
}

//MARK:- TABLE VIEW -
extension Login: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LoginTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LoginTableCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txtEmailAddress.delegate = self
        cell.txtPassword.delegate = self
        
        cell.btnSaveAndContinue.addTarget(self, action: #selector(signInClickMethod), for: .touchUpInside)
        cell.btnDontHaveAnAccount.addTarget(self, action: #selector(dontHaveAntAccountClickMethod), for: .touchUpInside)
        cell.btnForgotPassword.addTarget(self, action: #selector(btnForgotPasswordPress), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnForgotPasswordPress() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotPassword") as? ForgotPassword
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func signInClickMethod() {
        
        self.login_WB()
        
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSAddressId")
         self.navigationController?.pushViewController(push, animated: true)*/
    }
    
    @objc func dontHaveAntAccountClickMethod() {
        
        let settingsVCId = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegistraitonId") as? Registraiton
        self.navigationController?.pushViewController(settingsVCId!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 900
    }
    
}

extension Login: UITableViewDelegate {
    
}
