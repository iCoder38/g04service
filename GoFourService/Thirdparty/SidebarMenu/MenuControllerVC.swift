//
//  MenuControllerVC.swift
//  SidebarMenu
//
//  Created by Apple  on 16/10/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MenuControllerVC: UIViewController {

    let cellReuseIdentifier = "menuControllerVCTableCell"
    
    var bgImage: UIImageView?
    
    var roleIs:String!
    
    @IBOutlet weak var navigationBar:UIView! {
        didSet {
            navigationBar.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var viewUnderNavigation:UIView! {
        didSet {
            viewUnderNavigation.backgroundColor = .black
        }
    }
    
    @IBOutlet weak var lblNavigationTitle:UILabel! {
        didSet {
            lblNavigationTitle.text = "MENU"
            lblNavigationTitle.textColor = .white
        }
    }
    
    @IBOutlet weak var imgSidebarMenuImage:UIImageView! {
        didSet {
            imgSidebarMenuImage.backgroundColor = .clear
            imgSidebarMenuImage.layer.cornerRadius = 35
            imgSidebarMenuImage.clipsToBounds = true
        }
    }
    
    // Member
    var arr_customer_title = ["Dashboard", "Edit profile","Order History", "Change Password", "Help", "Logout"]
    var arr_customer_image = ["home","edit2","trip","lock","help","logout"]
    
    // driver
    var arr_driver_title = ["Dashboard", "Edit profile","Order History", "New Orders" , "Go4Card" , "Review & Rating" , "Earnings" , "Cashout" , "Invite Friends($5)" ,"Change password" , "Logout" ]
    var arr_driver_image = ["home","edit2","trip","lock","help","logout"]
    
    
    @IBOutlet weak var lblUserName:UILabel! {
        didSet {
            lblUserName.text = "JOHN SMITH"
            lblUserName.textColor = .white
        }
    }
    @IBOutlet weak var lblPhoneNumber:UILabel! {
        didSet {
            lblPhoneNumber.textColor = .white
        }
    }
    
    @IBOutlet var menuButton:UIButton!
    
    @IBOutlet weak var tbleView: UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
            tbleView.tableFooterView = UIView.init()
            tbleView.backgroundColor = NAVIGATION_COLOR
            // tbleView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            tbleView.separatorColor = .white
        }
    }
    @IBOutlet weak var lblMainTitle:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBarMenuClick()
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.tbleView.separatorColor = .white

        self.view.backgroundColor = .white
        
        self.sideBarMenuClick()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
             if person["role"] as! String == "Member" {
                
                self.lblUserName.text = (person["username"] as! String)
                self.lblPhoneNumber.text = (person["contactNumber"] as! String)
                 
             } else {
                
                self.lblUserName.text = (person["fullName"] as! String)
                self.lblPhoneNumber.text = (person["contactNumber"] as! String)
                
                // imgSidebarMenuImage.sd_setImage(with: URL(string: (person["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            }
             
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @objc func sideBarMenuClick() {
        
        if revealViewController() != nil {
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
            revealViewController().rearViewRevealWidth = 300
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }
    }
}

extension MenuControllerVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
        
            if person["role"] as! String == "Member" {
                return arr_customer_title.count
            } else {
                return self.arr_driver_title.count
            }
            
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuControllerVCTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MenuControllerVCTableCell
        
        cell.backgroundColor = .clear
      
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
        
            if person["role"] as! String == "Member" {
            
         cell.lblName.text = self.arr_customer_title[indexPath.row]
         cell.lblName.textColor = .white
         
         cell.imgProfile.image = UIImage(named: self.arr_customer_image[indexPath.row])
         cell.imgProfile.backgroundColor = .clear
         
            } else {
                
                cell.lblName.text = self.arr_driver_title[indexPath.row]
                cell.lblName.textColor = .white
                
                // cell.imgProfile.image = UIImage(named: self.arr_customer_image[indexPath.row])
                // cell.imgProfile.backgroundColor = .clear
 
            }
            
        } else {
        
            // temp
        
        
         }
        
        
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if person["role"] as! String == "Member" {
                
                if self.arr_customer_title[indexPath.row] == "Change Password" {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassword")
                    let navigationController = UINavigationController(rootViewController: destinationController!)
                    sw.setFront(navigationController, animated: true)
                    
                }
                
                else if self.arr_customer_title[indexPath.row] == "Dashboard" {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "UPDSDashboardId")
                    let navigationController = UINavigationController(rootViewController: destinationController!)
                    sw.setFront(navigationController, animated: true)
                    
                }
                
                else if self.arr_customer_title[indexPath.row] == "Order History" {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "UPDSOrderHistory")
                    let navigationController = UINavigationController(rootViewController: destinationController!)
                    sw.setFront(navigationController, animated: true)
                    
                }
                
                else if self.arr_customer_title[indexPath.row] == "Help" {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "Help")
                    let navigationController = UINavigationController(rootViewController: destinationController!)
                    sw.setFront(navigationController, animated: true)
                    
                }
                /*if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
                 
                 if person["role"] as! String == "Driver" {
                 
                 if arrSidebarMenuDriverTitle[indexPath.row] == "Home" {
                 
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                 self.view.window?.rootViewController = sw
                 let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "DDashbaordId")
                 let navigationController = UINavigationController(rootViewController: destinationController!)
                 sw.setFront(navigationController, animated: true)
                 
                 } else if arrSidebarMenuDriverTitle[indexPath.row] == "Logout" {
                 
                 let alert = UIAlertController(title: String("Logout"), message: String("Are you sure you want to logout ?"), preferredStyle: UIAlertController.Style.alert)
                 alert.addAction(UIAlertAction(title: "Yes, Logout", style: .default, handler: { action in
                 // self.logoutWB()
                 }))
                 alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { action in
                 }))
                 self.present(alert, animated: true, completion: nil)
                 
                 }
                 
                 }
                 
                 }*/
                
            } else {
                
                if self.arr_driver_title[indexPath.row] == "Order History" {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "order_history_for_driver_id") as? order_history_for_driver
                    let navigationController = UINavigationController(rootViewController: destinationController!)
                    sw.setFront(navigationController, animated: true)
                    
                } else if self.arr_driver_title[indexPath.row] == "New Orders" {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "driver_new_orders_id") as? driver_new_orders
                    let navigationController = UINavigationController(rootViewController: destinationController!)
                    sw.setFront(navigationController, animated: true)
                    
                }
                
            }
            
        }
    }
    
    /*
    @objc func logoutWB() {
         ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        self.view.endEditing(true)
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
         // let str:String = person["role"] as! String
        
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
        let params = LogoutFromApp(action: "logout",
                                   userId: String(myString))
        
        AF.request(APPLICATION_BASE_URL,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    // debugPrint(response.result)
                    
                    switch response.result {
                    case let .success(value):
                        
                        let JSON = value as! NSDictionary
                          // print(JSON as Any)
                        
                        var strSuccess : String!
                        strSuccess = JSON["status"]as Any as? String
                        
                        // var strSuccess2 : String!
                        // strSuccess2 = JSON["msg"]as Any as? String
                        
                        if strSuccess == String("success") {
                            print("yes")
                            ERProgressHud.sharedInstance.hide()
                           
                            let defaults = UserDefaults.standard
                            defaults.setValue("", forKey: "keyLoginFullData")
                            defaults.setValue(nil, forKey: "keyLoginFullData")

                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let sw = storyboard.instantiateViewController(withIdentifier: "sw") as! SWRevealViewController
                            self.view.window?.rootViewController = sw
                            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomePageId")
                            let navigationController = UINavigationController(rootViewController: destinationController!)
                            sw.setFront(navigationController, animated: true)
                            
                        } else {
                            
                            print("no")
                            ERProgressHud.sharedInstance.hide()
                            
                            var strSuccess2 : String!
                            strSuccess2 = JSON["msg"]as Any as? String
                            
                            Utils.showAlert(alerttitle: String(strSuccess), alertmessage: String(strSuccess2), ButtonTitle: "Ok", viewController: self)
                            
                        }
                        
                    case let .failure(error):
                        print(error)
                        ERProgressHud.sharedInstance.hide()
                        
                        Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                    }
        }
    }
    } */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MenuControllerVC: UITableViewDelegate {
    
}
