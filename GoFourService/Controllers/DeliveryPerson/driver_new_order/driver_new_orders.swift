//
//  driver_new_orders.swift
//  GoFourService
//
//  Created by Dishant Rajput on 30/09/22.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftGifOrigin

class driver_new_orders: UIViewController , CustomSegmentedControlDelegate {

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
            lblNavigationTitle.text = "New Orders"
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
            
            interfaceSegmented.setButtonTitles(buttonTitles: ["Deliver","G04Customer"])
            
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
            self.new_order_deliver_list_WB()
            
        } else if self.str_user_select == "1" {
            
            self.arr_mut_order_history.removeAllObjects()
            self.new_go_4_deliver_list_WB()
            
        }
        
    }
    
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        
        self.page = 1
        
        if "\(index)" == "0" {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.new_order_deliver_list_WB()
            
        } else if "\(index)" == "1" {
            
            self.str_user_select = "\(index)"
            
            self.arr_mut_order_history.removeAllObjects()
            self.new_go_4_deliver_list_WB()
            
        }
        
    }

    @objc func new_order_deliver_list_WB() {
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
                "driverId"  : String(myString),
                
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
    
    @objc func new_go_4_deliver_list_WB() {
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
                "driverId"  : String(myString),
                
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
    
    
    @objc func new_order_dismiss_job_WB(str_driver_id:String,
                                        str_to_get_driver_request_id:String,
                                        str_to_get_request_id:String,
                                        str_status:String) {
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
            
            /*
             [action] => togetrequestaccept
                 [driverId] => 25
                 [togetDriverRequestId] => 44
                 [togetRequestId] => 16
                 [status] => 3
             */
            let parameters = [
                "action"                : "togetrequestaccept",
                "driverId"              : String(str_driver_id),
                "togetDriverRequestId"  : String(str_to_get_driver_request_id),
                "togetRequestId"        : String(str_to_get_request_id),
                "status"                : String(str_status),
                
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
                                
                                self.arr_mut_order_history.removeAllObjects()
                                self.new_go_4_deliver_list_WB()
                                
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
extension driver_new_orders: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_order_history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:driver_new_orders_table_cell = tableView.dequeueReusableCell(withIdentifier: "driver_new_orders_table_cell") as! driver_new_orders_table_cell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        let item = self.arr_mut_order_history[indexPath.row] as? [String:Any]
        print(item as Any)
        
        if self.str_user_select == "0" {
        
            cell.lblRestaurantName.text = (item!["resturentName"] as! String)
            
            cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgFoodImage.sd_setImage(with: URL(string: (item!["resturentImage"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            var ar : NSArray!
            ar = (item!["foodDetails"] as! Array<Any>) as NSArray
            
            if "\(ar.count)" == "0" || "\(ar.count)" == "1" {
                cell.lbl_total_item.text = "\(ar.count) item"
            } else {
                cell.lbl_total_item.text = "\(ar.count) items"
            }
            
            cell.lbl_pick.text = (item!["resturentddress"] as! String)
            cell.lbl_drop.text = (item!["address"] as! String)
            
            cell.lbl_price.text = "Price : $\(item!["totalAmount"]!)"
            
            cell.lbl_drop_text.isHidden = false
            cell.lbl_drop.isHidden = false
            cell.lbl_total_item.isHidden = false
            
        } else {
            
            cell.lblRestaurantName.text = "\(item!["userName"]!) -$\(item!["totalAmount"]!)"
            
            //cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgFoodImage.image = UIImage(named: "logo")
            
            
            cell.lbl_pick_text.text = "Address :"
            cell.lbl_pick.text = (item!["address"] as! String)
            
            cell.lbl_price.text = (item!["wahtUwant"] as! String)+" "+(item!["StoreCity"] as! String)
            
            cell.lbl_drop_text.isHidden = true
            cell.lbl_drop.isHidden = true
            cell.lbl_total_item.isHidden = true
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_mut_order_history[indexPath.row] as? [String:Any]
        
        if self.self.str_user_select == "0" {
            
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "driver_new_order_deliver_details_id") as? driver_new_order_deliver_details
            
            push!.str_food_order_id = "\(item!["foodorderId"]!)"
            
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            
            let alert = NewYorkAlertController(title: String("To Get Request").uppercased(), message: "Product name : \(item!["wahtUwant"]!)\n\nStore name : \(item!["StoreCity"]!)\n\nAddress : \(item!["address"]!)", style: .alert)
            
            let skip = NewYorkButton(title: "Skip Job", style: .default) {
                _ in
                /*
                 [action] => togetrequestaccept
                     [driverId] => 25
                     [togetDriverRequestId] => 44
                     [togetRequestId] => 16
                     [status] => 3
                 */
                
                self.new_order_dismiss_job_WB(str_driver_id: "\(item!["driverId"]!)",
                                              str_to_get_driver_request_id: "\(item!["togetDriverRequestId"]!)",
                                              str_to_get_request_id: "\(item!["togetRequestId"]!)",
                                              str_status: "3")
                
            }
            let accept = NewYorkButton(title: "Accept Job", style: .default) {
                _ in
                /*
                 [action] => togetrequestaccept
                     [driverId] => 25
                     [togetDriverRequestId] => 33
                     [togetRequestId] => 14
                     [status] => 2
                 */
                self.new_order_dismiss_job_WB(str_driver_id: "\(item!["driverId"]!)",
                                              str_to_get_driver_request_id: "\(item!["togetDriverRequestId"]!)",
                                              str_to_get_request_id: "\(item!["togetRequestId"]!)",
                                              str_status: "2")
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            skip.setDynamicColor(.pink)
            accept.setDynamicColor(.green)
            
            alert.addButtons([skip,accept,cancel])
            
            present(alert, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


class driver_new_orders_table_cell: UITableViewCell {
    
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
    @IBOutlet weak var lbl_total_item:UILabel!{
        didSet{
            lbl_total_item.layer.cornerRadius = 5.0
            lbl_total_item.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_price:UILabel!
    @IBOutlet weak var lbl_pick:UILabel!
    @IBOutlet weak var lbl_drop:UILabel!
    
    @IBOutlet weak var lbl_pick_text:UILabel!
    @IBOutlet weak var lbl_drop_text:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
