//
//  order_history_for_driver.swift
//  GoFourService
//
//  Created by Dishant Rajput on 26/09/22.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftGifOrigin


class order_history_for_driver: UIViewController , CustomSegmentedControlDelegate {
    
    // var str_profile_status:String!
    
    var str_user_select:String! = "0"
    
    var arr_mut_order_history:NSMutableArray! = []
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
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
            
            interfaceSegmented.setButtonTitles(buttonTitles: ["Deliver","Drop off","G04Customer"])
            
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
        
        
        if self.str_user_select == "0" {
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_order_history(page_number: 1)
            
        } else if self.str_user_select == "1" {
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_booking_details(page_number: 1)
            
        } else {
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_go_get_list(page_number: 1)
            
        }
        
    }
    
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        
        self.page = 1
        
        if "\(index)" == "0" {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_order_history(page_number: 1)
            
        } else if "\(index)" == "1" {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_booking_details(page_number: 1)
            
        } else {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.get_go_get_list(page_number: 1)
            
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        if scrollView == self.tbleView {
            let isReachingEnd = scrollView.contentOffset.y >= 0
                && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
            if(isReachingEnd) {
                if(loadMore == 1) {
                    loadMore = 0
                    page += 1
                    print(page as Any)
                    
                    if self.str_user_select == "0" {
                        
                        self.get_order_history(page_number: page)
                        
                    } else if self.str_user_select == "1" {
                        self.get_booking_details(page_number: page)
                    } else {
                        self.get_go_get_list(page_number: page)
                    }
                    
                }
            }
        }
    }
    
    
    @objc func get_order_history(page_number:Int) {
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
                "pageNo"    : page_number,
            ] as [String : Any]
            
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
                                self.loadMore = 1
                                
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
    
    @objc func get_booking_details(page_number:Int) {
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
                "pageNo"    : page_number,
                
            ] as [String : Any]
            
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
                                self.loadMore = 1
                                
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
    
    @objc func get_go_get_list(page_number:Int) {
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
                "pageNo"    : page_number,
                
            ] as [String : Any]
            
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
                                self.loadMore = 1
                                
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
extension order_history_for_driver: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_order_history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:order_history_for_driver_table_cell = tableView.dequeueReusableCell(withIdentifier: "order_history_for_driver_table_cell") as! order_history_for_driver_table_cell
        
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
                
            } else if "\(item!["status"]!)" == "2" {
                
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
            
            
            
            
            /*
             0=send, 1=accepted, 2=PickupArrived, 3=RideStart,4=dropStatus,5=PaymentDone, 6= Driver not be available, 7= Cancel by someone
             */
            
//            if "\(item!["rideStatus"]!)" == "0" {
//
//
//
//            } else
            if "\(item!["rideStatus"]!)" == "1" {
                
                
                cell.img_gif_on_the_way.image = UIImage(systemName: "hand.thumbsup.fill")
                cell.img_gif_on_the_way.tintColor = .systemOrange
                
                cell.lblStatus.text = " Accepted "
                cell.lblStatus.backgroundColor = .systemOrange
                
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
                
            } else if "\(item!["rideStatus"]!)" == "2" {
                
                // cell.lblStatus.text = " Arrived "
                cell.img_gif_on_the_way.image = UIImage(systemName: "car")
                cell.img_gif_on_the_way.tintColor = .systemPink
                
                cell.lblStatus.text = " Arrived "
                cell.lblStatus.backgroundColor = .systemPink
                
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.systemPink.cgColor
                
            }
            else if "\(item!["rideStatus"]!)" == "3" {

                cell.img_gif_on_the_way.image = UIImage(systemName: "car")
                cell.img_gif_on_the_way.tintColor = .systemPurple
                
                cell.lblStatus.text = " Ride Start "
                cell.lblStatus.backgroundColor = .systemPurple

                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.systemPurple.cgColor

            }
            else if "\(item!["rideStatus"]!)" == "4" {
                
                cell.img_gif_on_the_way.image = UIImage(systemName: "dollarsign.circle")
                cell.img_gif_on_the_way.tintColor = .darkGray
                
                cell.lblStatus.text = " pending... "
                cell.lblStatus.backgroundColor = .darkGray
                
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
                
            } else if "\(item!["rideStatus"]!)" == "5" {
                
                cell.img_gif_on_the_way.image = UIImage(systemName: "checkmark")
                cell.img_gif_on_the_way.tintColor = .systemGreen
                
                cell.lblStatus.text = " Done "
                cell.lblStatus.backgroundColor = .systemGreen
                
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
                
            } else if "\(item!["rideStatus"]!)" == "7" {
                
                cell.img_gif_on_the_way.image = UIImage(named: "cancel")
                cell.lblStatus.text = " Cancel "
                cell.lblStatus.backgroundColor = .systemRed
                
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
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
            
            if "\(item!["rideStatus"]!)" == "1" {
                
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "driver_accept_requests_id") as? driver_accept_requests
                
                push!.dict_get_full_data = (item! as NSDictionary)
                
                push!.str_customer_name = (item!["fullName"] as! String)
                push!.str_customer_contact_number = (item!["contactNumber"] as! String)
                push!.str_driver_status_from = "1"
                
                self.navigationController?.pushViewController(push!, animated: true)
                
            } else if "\(item!["rideStatus"]!)" == "2" {
                
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "driver_accept_requests_id") as? driver_accept_requests
                
                push!.dict_get_full_data = (item! as NSDictionary)
                
                push!.str_customer_name = (item!["fullName"] as! String)
                push!.str_customer_contact_number = (item!["contactNumber"] as! String)
                push!.str_driver_status_from = "1"
                
                self.navigationController?.pushViewController(push!, animated: true)
                
            } else if "\(item!["rideStatus"]!)" == "3" {
                
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "driver_accept_requests_id") as? driver_accept_requests
                
                push!.dict_get_full_data = (item! as NSDictionary)
                
                push!.str_customer_name = (item!["fullName"] as! String)
                push!.str_customer_contact_number = (item!["contactNumber"] as! String)
                push!.str_driver_status_from = "1"
                
                self.navigationController?.pushViewController(push!, animated: true)
                
            } else if "\(item!["rideStatus"]!)" == "7" {
                
                let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("This ride has been cancelled"), style: .alert)
                let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                alert.addButtons([cancel])
                present(alert, animated: true)
                
            } else if "\(item!["rideStatus"]!)" == "4" {
                //
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDOInvoice_id") as? UPDOInvoice
                
                push!.get_dict_invoice = (item! as NSDictionary)
                push!.str_invoice_driver_screen_from = "1"
                
                self.navigationController?.pushViewController(push!, animated: true)
                
            } else if "\(item!["rideStatus"]!)" == "5" {
                
                let alert = NewYorkAlertController(title: String("Hurray!").uppercased(), message: String("This ride has been completed."), style: .alert)
                let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                alert.addButtons([cancel])
                present(alert, animated: true)
                
            }
            
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


class order_history_for_driver_table_cell: UITableViewCell {
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            viewCellbg.backgroundColor = .white
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var imgFoodImage:UIImageView! {
        didSet {
            imgFoodImage.layer.cornerRadius = 8
            imgFoodImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lblRestaurantName:UILabel!
    @IBOutlet weak var lblTotalItem:UILabel!{
        didSet{
            lblTotalItem.layer.cornerRadius = 5.0
            lblTotalItem.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblTotalAmount:UILabel!
    @IBOutlet weak var lblDateNTime:UILabel!
    
    @IBOutlet weak var lbl_drop_location:UILabel!
    @IBOutlet weak var lbl_pick_up_location:UILabel!
    
    @IBOutlet weak var lblStatus:UILabel!{
        didSet{
            lblStatus.layer.cornerRadius = 5.0
            lblStatus.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var img_gif_on_the_way:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
