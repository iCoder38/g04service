//
//  UPDSOrderHistory.swift
//  GoFourService
//
//  Created by Dishant Rajput on 22/10/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftGifOrigin

class UPDSOrderHistory: UIViewController , CustomSegmentedControlDelegate {
    
    // var str_profile_status:String!
    
    var str_user_select:String! = "0"
    
    var arr_mut_order_history:NSMutableArray! = []
    
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
            lblNavigationTitle.text = ORDERHISTORY_NAVIGATION_TITLE
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    
    let cellReuseIdentifier = "OrderHistoryTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            // tbleView.delegate = self
            // tbleView.dataSource = self
        }
    }
    
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl! {
        didSet {
            interfaceSegmented.backgroundColor = .white
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                if person["role"] as! String == "Member" {
                    
                    interfaceSegmented.setButtonTitles(buttonTitles: ["Deliver","Drop off","G04Customer"])
                    
                } else {
                    
                    interfaceSegmented.setButtonTitles(buttonTitles: ["Deliver","G04Customer"])
                    
                }
            }
            
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        self.interfaceSegmented.delegate = self
        
        self.side_bar_menu_click(self.sideMenu)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if person["role"] as! String == "Member" {
                
                if self.str_user_select == "0" {
                    
                    self.arr_mut_order_history.removeAllObjects()
                    self.get_order_history()
                    
                } else if self.str_user_select == "1" {
                    
                    self.arr_mut_order_history.removeAllObjects()
                    self.get_booking_details()
                    
                } else {
                    
                    self.arr_mut_order_history.removeAllObjects()
                    self.get_go_get_list()
                    
                }
                
            } else {
                
                if self.str_user_select == "0" {
                    
                    self.arr_mut_order_history.removeAllObjects()
                    self.food_order_list_from_driver_wb()
                    
                } else {
                    
                    self.arr_mut_order_history.removeAllObjects()
                    self.to_get_list_from_driver_wb()
                    
                }
                
            }
            
        }
        
    }
    
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        
        if "\(index)" == "0" {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_order_history()
            
        } else if "\(index)" == "1" {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_booking_details()
            
        } else {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_go_get_list()
            
        }
        
    }
    
    @objc func get_order_history() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        /*
         [action] => foodorderlist
         [userId] => 43
         [status] =>
         [userType] => Member
         [dateBy] =>
         [pageNo] => 1
         */
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            
            let parameters = [
                "action"    : "foodorderlist",
                "userId"    : String(myString),
                "userType"  : (person["role"] as! String),
                "pageNo"    : "1",
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
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_order_history.addObjects(from: ar as! [Any])
                                
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
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
    }
    
    @objc func get_booking_details() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        /*
         [action] => foodorderlist
         [userId] => 43
         [status] =>
         [userType] => Member
         [dateBy] =>
         [pageNo] => 1
         */
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            
            let parameters = [
                "action"    : "bookinglist",
                "userId"    : String(myString),
                "userType"  : (person["role"] as! String),
                "pageNo"    : "1",
                
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
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_order_history.addObjects(from: ar as! [Any])
                                
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
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
    }
    
    @objc func get_go_get_list() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        /*
         [action] => foodorderlist
         [userId] => 43
         [status] =>
         [userType] => Member
         [dateBy] =>
         [pageNo] => 1
         */
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            
            let parameters = [
                "action"    : "gogetlist",
                "userId"    : String(myString),
                "userType"  : (person["role"] as! String),
                "pageNo"    : "1",
                
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
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_order_history.addObjects(from: ar as! [Any])
                                
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
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
    }
    
    
    // MARK: - WEBSERVICE FOR DRIVER SIDE -
    @objc func food_order_list_from_driver_wb() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
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
                "action"    : "foodorderrequestlist",
                "driverId"    : String(myString),
                
                
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
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_order_history.addObjects(from: ar as! [Any])
                                
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
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
    }
    
    
    @objc func to_get_list_from_driver_wb() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
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
                "action"    : "togetdriverrequestlist",
                "driverId"    : String(myString),
                
                
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
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_order_history.addObjects(from: ar as! [Any])
                                
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
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
    }
    
}

//MARK:- TABLE VIEW -
extension UPDSOrderHistory: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_order_history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UPDSOrderHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSOrderHistoryTableViewCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        let item = self.arr_mut_order_history[indexPath.row] as? [String:Any]
        
        if self.str_user_select == "0" {
            
            cell.lblRestaurantName.text = (item!["resturentName"] as! String)
            
            var ar : NSArray!
            ar = (item!["foodDetails"] as! Array<Any>) as NSArray
            
            if "\(ar.count)" == "0" || "\(ar.count)" == "1" {
                cell.lblTotalItem.text = "\(ar.count) item"
            } else {
                cell.lblTotalItem.text = "\(ar.count) items"
            }
            
            
            if "\(item!["status"]!)" == "1" {
                
                cell.img_gif_on_the_way.image = UIImage(systemName: "hand.thumbsup.fill")
                cell.lblStatus.text = " Accepted "
                cell.lblStatus.backgroundColor = .systemOrange
                
            } else if "\(item!["status"]!)" == "4" {
                
                cell.img_gif_on_the_way.image = SDAnimatedImage(named: "shipped.gif")?.animatedImageFrame(at: 1)
                
                cell.lblStatus.text = " Completed "
                cell.lblStatus.backgroundColor = .systemGreen
                
            } else if "\(item!["status"]!)" == "6" {
                
                cell.img_gif_on_the_way.image = SDAnimatedImage(named: "on_the_way.gif")?.animatedImageFrame(at: 60)
                
                cell.lblStatus.text = " On the way "
                cell.lblStatus.backgroundColor = .systemYellow
                
            }
            
            if item!["resturentRating"] != nil {
                
                // rating
                if "\(item!["resturentRating"]!)" == "0" {
                    
                    cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarTwo.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarThree.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                    
                } else if "\(item!["resturentRating"]!)" == "1" {
                    
                    cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarTwo.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarThree.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                    
                } else if "\(item!["resturentRating"]!)" == "2" {
                    
                    cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarThree.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                    
                } else if "\(item!["resturentRating"]!)" == "3" {
                    
                    cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarThree.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                    cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                    
                } else if "\(item!["resturentRating"]!)" == "4" {
                    
                    cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarThree.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarFour.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                    
                } else {
                    
                    cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarThree.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarFour.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    cell.btnStarFive.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    
                }
                
            }
            
            
            cell.btnStarOne.isHidden = false
            cell.btnStarTwo.isHidden = false
            cell.btnStarThree.isHidden = false
            cell.btnStarFour.isHidden = false
            cell.btnStarFive.isHidden = false
            
            cell.lblTotalAmount.text = "Price : $\(item!["totalAmount"]!)"
            
            cell.lblDateNTime.text = (item!["created"] as! String)
            
            cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgFoodImage.sd_setImage(with: URL(string: (item!["resturentImage"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.img_gif_on_the_way.isHidden = false
            
            cell.lblStatus.isHidden = false
            cell.lblTotalItem.isHidden = false
            
            // <==> //
            // DROP OFF //
            // <==> //
        } else if self.str_user_select == "1" {
            
            cell.lblRestaurantName.text = (item!["fullName"] as! String)
            
            cell.lblTotalItem.text = (item!["created"] as! String)
            
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                if person["role"] as! String == "Member" {
                
                    
                } else {
                    
                }
                
            }
            
            if "\(item!["status"]!)" == "1" {
                
                cell.img_gif_on_the_way.image = UIImage(named: "cancel")
                cell.lblStatus.text = " Cancel "
                cell.lblStatus.backgroundColor = .systemRed
                
            } else if "\(item!["status"]!)" == "2" {
                
                cell.img_gif_on_the_way.image = SDAnimatedImage(named: "shipped.gif")?.animatedImageFrame(at: 1)
                
                cell.lblStatus.text = " Completed "
                cell.lblStatus.backgroundColor = .systemGreen
                
            } else {
                
            }
            
            // rating
            if "\(item!["AVGRating"]!)" == "0" {
                
                cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarTwo.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarThree.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                
            } else if "\(item!["AVGRating"]!)" == "1" {
                
                cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarTwo.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarThree.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                
            } else if "\(item!["AVGRating"]!)" == "2" {
                
                cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarThree.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                
            } else if "\(item!["AVGRating"]!)" == "3" {
                
                cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarThree.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarFour.setImage(UIImage(systemName: "star"), for: .normal)
                cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                
            } else if "\(item!["AVGRating"]!)" == "4" {
                
                cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarThree.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarFour.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarFive.setImage(UIImage(systemName: "star"), for: .normal)
                
            } else {
                
                cell.btnStarOne.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarTwo.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarThree.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarFour.setImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.btnStarFive.setImage(UIImage(systemName: "star.fill"), for: .normal)
                
            }
            
            cell.btnStarOne.isHidden = false
            cell.btnStarTwo.isHidden = false
            cell.btnStarThree.isHidden = false
            cell.btnStarFour.isHidden = false
            cell.btnStarFive.isHidden = false
            
            cell.img_gif_on_the_way.isHidden = false
            
            cell.lblStatus.isHidden = false
            cell.lblTotalItem.isHidden = false
            
            cell.lblTotalAmount.text = (item!["RequestPickupAddress"] as! String)
            
            cell.lblDateNTime.text = (item!["RequestDropAddress"] as! String)
            
            cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgFoodImage.sd_setImage(with: URL(string: (item!["carImage"] as! String)), placeholderImage: UIImage(named: "logo"))
            
        } else {
            
            cell.lblRestaurantName.text = (item!["userName"] as! String)
            
            cell.lblTotalItem.isHidden = true
            
            cell.lblTotalAmount.textColor = .systemPurple
            cell.lblTotalAmount.text = (item!["wahtUwant"] as! String)
            
            cell.lblDateNTime.text = "Store city : "+(item!["StoreCity"] as! String)
            
            cell.btnStarOne.isHidden = true
            cell.btnStarTwo.isHidden = true
            cell.btnStarThree.isHidden = true
            cell.btnStarFour.isHidden = true
            cell.btnStarFive.isHidden = true
            
            cell.img_gif_on_the_way.isHidden = true
            
            cell.lblStatus.isHidden = true
            
            cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgFoodImage.sd_setImage(with: URL(string: (item!["userImage"] as! String)), placeholderImage: UIImage(named: "logo"))
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.str_user_select == "0" {
            
            let item = self.arr_mut_order_history[indexPath.row] as? [String:Any]
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "order_history_details_id") as? order_history_details
            
            push!.str_food_order_id = "\(item!["foodorderId"]!)"
            
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else if self.str_user_select == "1" {
            
            let item = self.arr_mut_order_history[indexPath.row] as? [String:Any]
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "booking_history_details_id") as? booking_history_details
            
            // push!.get_dict_invoice = (item as! NSDictionary)
            push!.str_booking_order_id = "\(item!["bookingId"]!)"
            
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            
            
            let item = self.arr_mut_order_history[indexPath.row] as? [String:Any]
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPSCOrderDetails_id") as? UPSCOrderDetails
            
            push!.dict_get_go_4_customer = (item! as NSDictionary)
            
            self.navigationController?.pushViewController(push!, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension UPDSOrderHistory: UITableViewDelegate {
    
}
