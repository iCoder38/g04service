//
//  driver_new_order_deliver_details.swift
//  GoFourService
//
//  Created by Dishant Rajput on 30/09/22.
//

import UIKit
import Alamofire
import SDWebImage
import MapKit
import SwiftGifOrigin

class driver_new_order_deliver_details: UIViewController , CustomSegmentedControlDelegate {
    
    var str_select_segment:String! = "orders_list"
    
    var str_food_order_id:String!
    
    var arr_food_items:NSMutableArray! = []
    
    var dict_for_delivery_status:NSDictionary!
    
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
            lblNavigationTitle.text = ORDERHISTOR_Details_NAVIGATION_TITLE
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl! {
        didSet {
            interfaceSegmented.backgroundColor = .white
            interfaceSegmented.setButtonTitles(buttonTitles: ["Items" , "Payment" , "Delivery"])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            // tbleView.delegate = self
            // tbleView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tble_view.separatorColor = .clear
        
        self.interfaceSegmented.delegate = self
        
        self.sideMenu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.arr_food_items.removeAllObjects()
        self.food_order_details_wb(str_loader: "yes")
    }
    
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        
        if "\(index)" == "0" {
            self.str_select_segment = "orders_list"
        } else if "\(index)" == "1" {
            self.str_select_segment = "payment_option"
        } else {
            self.str_select_segment = "delivery_option"
        }
        
        self.tble_view.reloadData()
        
    }
    
    @objc func food_order_details_wb(str_loader:String) {
        self.view.endEditing(true)
        
        if str_loader == "yes" {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            
            let parameters = [
                "action"        : "foodorderdetails",
                "userId"        : String(myString),
                "foodorderId"   : String(self.str_food_order_id),
                
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url, method: .post, parameters: parameters)
            
                .response { response in
                    
                    do {
                        if response.error != nil{
                            print(response.error as Any, terminator: "")
                        }
                        
                        if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject] {
                            
                             print(jsonDict as Any, terminator: "====> ALL VALUEs HERE <====")
                            
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
                                
                                self.dict_for_delivery_status = dict as NSDictionary
                                
                                var ar : NSArray!
                                ar = (dict["foodDetailsNew"] as! Array<Any>) as NSArray
                                
                                for indexx in 0..<ar.count {
                                    
                                    let item = ar[indexx] as? [String:Any]
                                    
                                    let custom_dict = ["food_name" : (item!["foodName"] as! String),
                                                       "description" : (item!["description"] as! String),
                                                       "image" : (item!["image_1"] as! String),
                                                       "food_category" : (item!["foodTag"] as! String),
                                                       "price" : "\(item!["price"]!)",
                                                       "quantity" : "\(item!["quantity"]!)",
                                                       "tip" : "",
                                                       "taxes" : "",
                                                       "delivery" : "",
                                                       "service_fee" : "",
                                                       "total_amount" : "",
                                                       "resturentLatitude" :"",
                                                       "resturentLongitude" :"",
                                                       "deliveryLat" :"",
                                                       "deliveryLong" :"",
                                                       "show_status" : "orders_list"]
                                    
                                    self.arr_food_items.add(custom_dict)
                                }
                                
                                
                                
                                // payment option
                                let custom_dict_payment_option = ["food_name" : "",
                                                                  "description" : "",
                                                                  "image" : "",
                                                                  "food_category" : "",
                                                                  "price" : "",
                                                                  "quantity" : "",
                                                                  "tip" : "\(dict["TIP"]!)",
                                                                  "taxes" : "\(dict["salesTax"]!)",
                                                                  "delivery" : "\(dict["deliveryFee"]!)",
                                                                  "service_fee" : "\(dict["serviceFee"]!)",
                                                                  "total_amount" : "\(dict["totalAmount"]!)",
                                                                  "resturentLatitude" :"",
                                                                  "resturentLongitude" :"",
                                                                  "deliveryLat" :"",
                                                                  "deliveryLong" :"",
                                                                  "show_status" : "payment_option"]
                                
                                self.arr_food_items.add(custom_dict_payment_option)
                                
                                /*
                                 resturentLatitude = "28.6634697";
                                 resturentLongitude = "77.3239508";
                                 deliveryLat = "28.6634705";
                                 deliveryLong = "77.323945";
                                 */
                                
                                // direction option
                                let custom_dict_direction_option = ["food_name" : "",
                                                                  "description" : "",
                                                                  "image" : "",
                                                                  "food_category" : "",
                                                                  "price" : "",
                                                                  "quantity" : "",
                                                                  "tip" : "",
                                                                  "taxes" : "",
                                                                  "delivery" : "",
                                                                  "service_fee" : "",
                                                                  "total_amount" : "",
                                                                    "resturentLatitude" :"\(dict["resturentLatitude"]!)",
                                                                    "resturentLongitude" :"\(dict["resturentLongitude"]!)",
                                                                    "deliveryLat" :"\(dict["deliveryLat"]!)",
                                                                    "deliveryLong" :"\(dict["deliveryLong"]!)",
                                                                  "show_status" : "direction_option"]
                                
                                self.arr_food_items.add(custom_dict_direction_option)
                                
                                print(self.arr_food_items as Any)
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                
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
                        print(response.error as Any)
                         // print(response.error?.localizedDescription)
                        print(response.error as Any, terminator: "YES ERROR HAPPENS")
                    }
                }
        }
    }
    
    @objc func delivery_status_clicked_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DPFoodConfirmDelivery_id") as? DPFoodConfirmDelivery
        
        push!.dict_get_customer_data_for_driver = self.dict_for_delivery_status
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // MARK: - DRIVER ACCEPT FOOD -
    @objc func validation_before_pickup() {
        
        // print(self.dict_for_delivery_status as Any)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! driver_new_order_deliver_details_table_cell
        
        if cell.btn_delivery_status.titleLabel?.text == "Accepted" {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("You picked order from restaurant ?"), style: .alert)
            
            let yes_delivered = NewYorkButton(title: "yes, picked", style: .default) {
                _ in
                self.driver_pick_up_food_from_restaurant_clicl_method()
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([yes_delivered , cancel])
            self.present(alert, animated: true)
            
        }
        
        
        
    }
    @objc func driver_pick_up_food_from_restaurant_clicl_method() {
        self.view.endEditing(true)
        
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
                "action"        : "updatefoodorder",
                "driverId"      : "\(self.dict_for_delivery_status["driverId"]!)",
                "foodorderId"   : "\(self.dict_for_delivery_status["foodorderId"]!)",
                "status"        : String("2"),
                
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url, method: .post, parameters: parameters)
            
                .response { response in
                    
                    do {
                        if response.error != nil{
                            print(response.error as Any, terminator: "")
                        }
                        
                        if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject] {
                            
                             print(jsonDict as Any, terminator: "====> ALL VALUEs HERE <====")
                            
                            // for status alert
                            var status_alert : String!
                            status_alert = (jsonDict["status"] as? String)
                            
                            // for message alert
                            var str_data_message : String!
                            str_data_message = jsonDict["msg"] as? String
                            
                            if status_alert.lowercased() == "success" {
                                
                                print("=====> yes")
                                // ERProgressHud.sharedInstance.hide()
                                
                                // self.back_click_method()
                                self.arr_food_items.removeAllObjects()
                                self.food_order_details_wb(str_loader: "no")
                                
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
                        print(response.error as Any)
                         // print(response.error?.localizedDescription)
                        print(response.error as Any, terminator: "YES ERROR HAPPENS")
                    }
                }
        }
    }
    
}


//MARK:- TABLE VIEW -
extension driver_new_order_deliver_details: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if self.str_select_segment == "payment_option" {
//            return 1
//        } else {
            return self.arr_food_items.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.str_select_segment == "payment_option" {
            
            let cell:driver_new_order_deliver_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "payment_table_cell") as! driver_new_order_deliver_details_table_cell
            
            cell.backgroundColor = .white
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            let item = self.arr_food_items[indexPath.row] as? [String:Any]
            // print(item as Any)
            
            cell.lbl_tip_amount.text = "$"+(item!["tip"] as! String)
            cell.lbl_taxes.text = "$"+(item!["taxes"] as! String)
            cell.lbl_delivery_charge.text = "$"+(item!["delivery"] as! String)
            cell.lbl_service_fee.text = "$"+(item!["service_fee"] as! String)
            cell.lbl_total_amount.text = "$"+(item!["total_amount"] as! String)
            
            return cell
            
        } else if self.str_select_segment == "orders_list" {
           
            let cell:driver_new_order_deliver_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "details_table_cell") as! driver_new_order_deliver_details_table_cell
            
            cell.backgroundColor = .white
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            let item = self.arr_food_items[indexPath.row] as? [String:Any]
            
            cell.lbl_food_name.text = (item!["food_name"] as! String)
            cell.lbl_food_description.text = (item!["description"] as! String)
            
            cell.img_food_image.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.img_food_image.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            if (item!["food_category"] as! String) == "Veg" {
                cell.img_food_category.image = UIImage(named: "veg")
            } else {
                cell.img_food_category.image = UIImage(named: "non-veg")
            }
            
            cell.lbl_food_price.text = "Price : $\(item!["price"]!)"
            
            cell.btn_quantity.setTitle("\(item!["quantity"]!)", for: .normal)
            
            return cell
            
        } else {
            
            let cell:driver_new_order_deliver_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "delivery_table_cell") as! driver_new_order_deliver_details_table_cell
            
            cell.backgroundColor = .white
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.viewCellbg.backgroundColor = .white
            
            // let item = self.arr_food_items[indexPath.row] as? [String:Any]
            
            // print(self.dict_for_delivery_status as Any)
            
            cell.lbl_customer_name.text = (self.dict_for_delivery_status["name"] as! String)
            cell.lbl_restaurant_name.text = (self.dict_for_delivery_status["resturentName"] as! String)
            
            cell.lbl_customer_address.text = (self.dict_for_delivery_status["address"] as! String)
            cell.lbl_restaurant_address.text = (self.dict_for_delivery_status["resturentAddress"] as! String)
            
            cell.lbl_customer_landmark.text = (self.dict_for_delivery_status["landmark"] as! String)
            cell.lbl_customer_special_notes.text = (self.dict_for_delivery_status["specialNote"] as! String)
            
            cell.lbl_customer_total_price.text = "$\(self.dict_for_delivery_status["totalAmount"]!)"
            cell.lbl_restaurant_total_price.text = "$\(self.dict_for_delivery_status["totalAmount"]!)"
            
            cell.btn_delivery_status.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.btn_delivery_status.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.btn_delivery_status.layer.shadowOpacity = 1.0
            cell.btn_delivery_status.layer.shadowRadius = 15.0
            cell.btn_delivery_status.layer.masksToBounds = false
            cell.btn_delivery_status.layer.cornerRadius = 15
            cell.btn_delivery_status.backgroundColor = .white
            
            if "\(self.dict_for_delivery_status["status"]!)" == "2" {
                
                cell.img_gif.isHidden = false
                cell.img_gif.image = UIImage.gif(name: "on_the_way")
                cell.btn_delivery_status.setTitle("On the way", for: .normal)
                cell.btn_delivery_status.setTitleColor(.black, for: .normal)
                
                if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                    
                    if person["role"] as! String != "Member" {
                        
                        cell.btn_delivery_status.isUserInteractionEnabled = true
                        
                        cell.btn_delivery_status.addTarget(self, action: #selector(delivery_status_clicked_method), for: .touchUpInside)
                    }
                    
                }
                
            } else if "\(self.dict_for_delivery_status["status"]!)" == "4" {

                cell.img_gif.isHidden = false
                cell.img_gif.image = UIImage(named: "tick")
                cell.btn_delivery_status.setTitle("Completed", for: .normal)
                cell.btn_delivery_status.setTitleColor(.black, for: .normal)
                cell.btn_delivery_status.isUserInteractionEnabled = false
                
            } else if "\(self.dict_for_delivery_status["status"]!)" == "1" {
                
                cell.img_gif.isHidden = false
                cell.img_gif.image = UIImage(named: "shipped")
                cell.btn_delivery_status.setTitle("Accepted", for: .normal)
                cell.btn_delivery_status.setTitleColor(.white, for: .normal)
                cell.btn_delivery_status.backgroundColor = .systemOrange
                cell.btn_delivery_status.isUserInteractionEnabled = true
                
                if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                    
                    if person["role"] as! String != "Member" {
                        
                        cell.btn_delivery_status.isUserInteractionEnabled = true
                        
                        cell.btn_delivery_status.addTarget(self, action: #selector(validation_before_pickup), for: .touchUpInside)
                    }
                    
                }
                
            }
            
            
            
            return cell
            
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.arr_food_items[indexPath.row] as? [String:Any]
        
        if self.str_select_segment == "payment_option" {
            
            if (item!["show_status"] as! String) == "payment_option" {
                return 180
            } else {
                return 0
            }
            
        } else if self.str_select_segment == "orders_list" {
            
            if (item!["show_status"] as! String) == "payment_option" || (item!["show_status"] as! String) == "direction_option" {
                return 0
            } else {
                return 115
            }
            
        } else {
            
            if (item!["show_status"] as! String) == "direction_option" {
                return 802
            } else {
                return 0
            }
            
        }
        
    }
    
}

class driver_new_order_deliver_details_table_cell: UITableViewCell {
    
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
    
    @IBOutlet weak var img_food_image:UIImageView!
    
    @IBOutlet weak var img_food_category:UIImageView! {
        didSet {
            
        }
    }
    @IBOutlet weak var lbl_food_name:UILabel! {
        didSet {
            lbl_food_name.textColor = .black
        }
    }
    @IBOutlet weak var lbl_food_description:UILabel! {
        didSet {
            lbl_food_description.textColor = .black
        }
    }
    @IBOutlet weak var lbl_food_price:UILabel! {
        didSet {
            lbl_food_price.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_quantity:UIButton! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lbl_tip_amount:UILabel! {
        didSet {
            lbl_tip_amount.textColor = .lightGray
        }
    }
    
    @IBOutlet weak var lbl_taxes:UILabel! {
        didSet {
            lbl_taxes.textColor = .lightGray
        }
    }
    
    @IBOutlet weak var lbl_delivery_charge:UILabel! {
        didSet {
            lbl_delivery_charge.textColor = .lightGray
        }
    }
    
    @IBOutlet weak var lbl_service_fee:UILabel! {
        didSet {
            lbl_service_fee.textColor = .lightGray
        }
    }
    
    @IBOutlet weak var lbl_total_amount:UILabel! {
        didSet {
            lbl_tip_amount.textColor = .lightGray
        }
    }
    
    
    // delivery details
    @IBOutlet weak var lbl_total_price:UILabel! {
        didSet {
            lbl_total_price.textColor = .black
        }
    }
    
    @IBOutlet weak var map_delivery:MKMapView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var map_restaurant:MKMapView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lbl_customer_name:UILabel! {
        didSet {
            lbl_customer_name.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_restaurant_name:UILabel! {
        didSet {
            lbl_restaurant_name.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_delivery_status:UIButton! {
        didSet {
            btn_delivery_status.backgroundColor = .systemOrange
        }
    }
    
    @IBOutlet weak var lbl_customer_address:UILabel! {
        didSet {
            lbl_customer_address.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_customer_special_notes:UILabel! {
        didSet {
            lbl_customer_special_notes.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_customer_landmark:UILabel! {
        didSet {
            lbl_customer_landmark.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_restaurant_address:UILabel! {
        didSet {
            lbl_restaurant_address.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_customer_total_price:UILabel! {
        didSet {
            lbl_customer_total_price.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_restaurant_total_price:UILabel! {
        didSet {
            lbl_restaurant_total_price.textColor = .black
        }
    }
    
    @IBOutlet weak var img_gif:UIImageView! {
        didSet {
            img_gif.isHidden = true
            img_gif.backgroundColor = .clear
        }
    }
    
}
