//
//  DPFoodConfirmDelivery.swift
//  GoFourService
//
//  Created by Dishant Rajput on 27/10/21.
//

import UIKit
import Alamofire

class DPFoodConfirmDelivery: UIViewController {
    
    var dict_get_customer_data_for_driver:NSDictionary!
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = .white
                btnBack.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = "IN PROGRESS"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
    
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "FoodConfirmDeliveryTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var btnMarkDelivered:UIButton!{
        didSet{
            btnMarkDelivered.setTitle("Mark as Delivered", for: .normal)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tbleView.separatorColor = .clear
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btnMarkDelivered.addTarget(self, action: #selector(mark_as_delivered), for: .touchUpInside)
        
        // print(self.dict_get_customer_data_for_driver as Any)
        
        /*
         Optional({
             EstTime = "15 Minutes";
             Mile = "4 Mile";
             TIP = 1;
             address = "9/1, Block C, Yojna Vihar, Anand Vihar, Ghaziabad, Uttar Pradesh 110092, India";
             assignDriver = 25;
             cardNo = 4242;
             city = Ghaziabad;
             couponCode = "";
             created = "2022-06-10 17:19:00";
             deliveryFee = "2.5";
             deliveryLat = "28.6634705";
             deliveryLong = "77.323945";
             discount = 0;
             driverAVG = "3.59";
             driverContactNumber = 9865324421;
             driverId = 25;
             driverImage = "";
             driverName = driverp1;
             foodDetails =     (
                         {
                     foodImage = "";
                     foodType = Veg;
                     id = 20;
                     name = pizza;
                     price = 10;
                     quantity = 1;
                     resturentId = 32;
                 }
             );
             foodDetailsNew =     (
                         {
                     categoryId = 8;
                     description = "new pizza ";
                     foodName = pizza;
                     foodTag = Veg;
                     foodType = "";
                     "image_1" = "";
                     "image_2" = "";
                     "image_3" = "";
                     "image_4" = "";
                     "image_5" = "";
                     menuId = 20;
                     price = 20;
                     quantity = 1;
                     resturentId = 32;
                     specialPrice = 10;
                 }
             );
             foodId = "";
             foodorderId = 36;
             landmark = bxnxn;
             name = purnima;
             noContact = "";
             phone = 9696852312;
             resturentAddress = "9/1, Block C, Yojna Vihar, Anand Vihar, Ghaziabad, Uttar Pradesh 110092, India";
             resturentId = 32;
             resturentLatitude = "28.6634697";
             resturentLongitude = "77.3239508";
             resturentName = "Max Rest";
             revirewSubmited = No;
             salesTax = 20;
             serviceFee = "1.5";
             specialNote = bxnxn;
             state = "Uttar Pradesh";
             status = 6;
             storecity = "";
             totalAmount = 35;
             userAVG = "3.5";
             userId = 40;
             userName = vee1;
             whatYouWant = "";
             workPlace = Home;
             zipcode = 110092;
         })
         (lldb)
         */
        
        
        
    }
    
    @objc func mark_as_delivered() {
        
        let alert = NewYorkAlertController(title: String("Alert"), message: String("Mark as delivered ?"), style: .alert)
        
        let yes_delivered = NewYorkButton(title: "yes, delivered", style: .default) {
            _ in
            self.food_order_details_wb()
        }
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([yes_delivered , cancel])
        self.present(alert, animated: true)
        
    }

    @objc func food_order_details_wb() {
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
            
//            [action] => updatefoodorder
//                [driverId] => 25
//                [foodorderId] => 36
//                [status] => 4
            let parameters = [
                "action"        : "updatefoodorder",
                "driverId"      : "\(self.dict_get_customer_data_for_driver["driverId"]!)",
                "foodorderId"   : "\(self.dict_get_customer_data_for_driver["foodorderId"]!)",
                "status"        : String("4"),
                
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
                                
                                self.back_click_method()
                                
                                
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
extension DPFoodConfirmDelivery: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DPFoodConfirmDeliveryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DPFoodConfirmDeliveryTableViewCell
        
       // cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.lblName.text = (self.dict_get_customer_data_for_driver["resturentName"] as! String)
        cell.lblAdrees.text = (self.dict_get_customer_data_for_driver["address"] as! String)
        
        
        
        
        
        return cell
    }
 
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
}

extension DPFoodConfirmDelivery: UITableViewDelegate {
    
}
