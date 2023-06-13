//
//  UPDSCartList.swift
//  GoFourService
//
//  Created by Apple on 03/03/21.
//

import UIKit
import Alamofire
import SDWebImage

class UPDSCartList: UIViewController {

    var arr_cart_list_items:NSMutableArray! = []
    
    
    var str_cart_sub_total:String = "0"
    var str_cart_total:String = "0"
    
    var str_recall:String! = "0"
    
    var str_no_contact_on_delivery:String! = "0"
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                btnBack.tintColor = .white
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = CART_LIST_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "uPDSCartListTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
//            tbleView.delegate = self
//            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var txtView:UITextView! {
        didSet {
            txtView.layer.cornerRadius = 8
            txtView.clipsToBounds = true
            txtView.layer.borderWidth = 0.6
            txtView.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    @IBOutlet weak var btnPlaceOrder:UIButton! {
        didSet {
            btnPlaceOrder.backgroundColor = NAVIGATION_COLOR
            btnPlaceOrder.addTarget(self, action: #selector(placeOrderClickMethod), for: .touchUpInside)
            btnPlaceOrder.setTitle("Place order", for: .normal)
        }
    }
    
    @IBOutlet weak var lbl_total_items:UILabel! {
        didSet {
            lbl_total_items.textColor = .black
            lbl_total_items.isHidden = true
        }
    }
    
    @IBOutlet weak var btn_check_uncheck:UIButton! {
        didSet {
            // btn_check_uncheck.
            self.btn_check_uncheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_check_uncheck.addTarget(self, action: #selector(contact_on_delivery_click_method), for: .touchUpInside)
        
        self.tbleView.separatorColor = .clear
        
        self.cart_list_WB(str_loader: "yes")
    }
    
    @objc func placeOrderClickMethod() {
        
        
        // arr_mut_get_cart_list
        
        print(self.arr_cart_list_items as Any)
        
        /*
         [{"id":"12",
         "name":"hxffjj",
         "foodType":"Veg",
         "foodImage":"",
         "price":"2",
         "quantity":"4",
         "resturentId":"16"}]
         */
        
        let parse_mut_arr:NSMutableArray! = []
        
        for indexx in 0..<self.arr_cart_list_items.count {
         
            let item = self.arr_cart_list_items[indexx] as? [String:Any]
            
            let custom_dict = ["id":"\(item!["userId"]!)",
                               "name":(item!["foodName"] as! String),
                               "foodType":(item!["foodTag"] as! String),
                               "foodImage":(item!["foodImage"] as! String),
                               "price":"\(item!["specialPrice"]!)",
                               "quantity":"\(item!["quantity"]!)",
                               "resturentId":"\(item!["resturentId"]!)"]
            
            parse_mut_arr.add(custom_dict)
            
        }
         
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSCartDetailsId") as? UPDSCartDetails
        push!.arr_mut_get_cart_list = parse_mut_arr
        
        push!.str_sub_toal_amount = String(self.str_cart_total)
        push!.str_get_special_note_from_cart = String(self.txtView.text!)
        push!.str_no_contact_on_delivery = String(self.str_no_contact_on_delivery)
        
        
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }

    
    // MARK: - ( WEBSERVICE ) CART LIST -
    @objc func cart_list_WB(str_loader:String) {
        
        self.arr_cart_list_items.removeAllObjects()
        
        self.view.endEditing(true)
        
        if str_loader == "yes" {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
         
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = get_cart_params(action: "getcarts",
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
                        
                        var ar : NSArray!
                        ar = (JSON["data"] as! Array<Any>) as NSArray
                        
                        if ar.count == 0 {
                            
                            self.tbleView.isHidden = true
                            // self.str_checkout_button_hide = "0"
                            
                        } else {
                         
                            self.tbleView.isHidden = false
                            // self.str_checkout_button_hide = "1"
                            
                            self.arr_cart_list_items.addObjects(from: ar as! [Any])
                            
                            var product_total_quantity :String!
                            var total_sum = Double(0.0)
                            
                            for indexx in 0..<self.arr_cart_list_items.count {
                                
                                let item = self.arr_cart_list_items[indexx] as? [String:Any]
                                 print(item as Any)

                                if "\(item!["quantity"]!)" == "" {
                                    product_total_quantity = "1"
                                } else {
                                    product_total_quantity = "\(item!["quantity"]!)"
                                }
                                
                                print("\(item!["specialPrice"]!)")
                                print(product_total_quantity as Any)
                                
                                let add_total_with_quantity = Double("\(item!["specialPrice"]!)")!*Double(product_total_quantity)!
                                let formatted_add_total_with_quantity = String(format: "%.2f", add_total_with_quantity)
                                
                                
                                print("PP with q =======>",formatted_add_total_with_quantity as Any)
                                
                                
                                total_sum = total_sum+Double(formatted_add_total_with_quantity)!
                                let formatted_total_sum = String(format: "%.2f", total_sum)
                                print("final after add ======>",formatted_total_sum as Any)
                                
                                self.str_cart_sub_total = String(formatted_total_sum)
                            }
                            
                            // print(self.str_cart_sub_total as Any)
                            
                            
                            // shipping
                            let shipping_charge:String! = "0"
                            
                            // delivery
                            let delivery_charge:String! = "0"
                            
                            // add all to get total
                            let add_all_values_for_total = Double(self.str_cart_sub_total)!+Double(shipping_charge)!+Double(delivery_charge)!
                            let formatted_add_all_values_for_total = String(format: "%.2f", add_all_values_for_total)
                            self.str_cart_total = String(formatted_add_all_values_for_total)
                            
                            let bigNumber = Double(self.str_cart_total)
                            let numberFormatter = NumberFormatter()
                            numberFormatter.numberStyle = .currency
                            let formattedNumber = numberFormatter.string(from: bigNumber! as NSNumber)
                            // cell.lblRealPrice.text = "\(formattedNumber!)"
                            
                            self.btnPlaceOrder.setTitle("Place order : \(formattedNumber!)", for: .normal)
                            
                            if self.str_recall == "0" {
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
                                self.tbleView.reloadData()
                            }
                            
                            // self.str_recall = "0"
                            
                        }
                        
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
    
    
    @objc func stepperValueChanged_2(stepper: GMStepper) {
        
        print("dishant rajput")
        
        let item = self.arr_cart_list_items[stepper.tag] as? [String:Any]
        print(item as Any)
        
        print(Int(stepper.value))
        
        print(stepper.tag as Any)
        
        print("\(item!["quantity"]!)")
        
        if "\(Int(stepper.value))" == "0" {
            
            self.delete_all_items_cart(str_food_id: "\(item!["foodId"]!)")
            return
            
        } else {
            
//            if self.str_recall == "0" {
                
                self.add_to_cart(str_food_id: "\(item!["foodId"]!)",
                                 str_quantity: "\(Int(stepper.value))")
                
//            }
            
            
            // return
            
        }

    }
    
    // MARK: - ADD ONE QUANTITY TO CART -
    @objc func add_to_cart(str_food_id:String , str_quantity:String) {
        
         self.str_recall = "1"
        
        // self.arr_cart_list_items.removeAllObjects()
        
        self.view.endEditing(true)
        
        // if str_loader == "yes" {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        // }
         
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = cart_list_params(action: "addcart",
                                          userId: String(myString),
                                          foodId: String(str_food_id),
                                          quantity: String(str_quantity))
            
            
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
                        
                        // ERProgressHud.sharedInstance.hide()
                        
                         self.cart_list_WB(str_loader: "no")
                        
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
    
    // MARK: - REMOVE ONE QUANTITY FROM CART -
    @objc func delete_all_items_cart(str_food_id:String) {
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
                "action"    : "deletecarts",
                "userId"    : String(myString),
                "foodId"      : String(str_food_id),
                // "quantity"    : String(str_quantity),
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
                                // ERProgressHud.sharedInstance.hide()
                                
                                //self.menu_list_WB(str_loader: "no")
                                
                                self.cart_list_WB(str_loader: "no")
                                
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
    }
    
    
    @objc func contact_on_delivery_click_method() {
    
        if self.btn_check_uncheck.tag == 0 {
            
            self.str_no_contact_on_delivery = "1"
            self.btn_check_uncheck.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.btn_check_uncheck.tag = 1
            
        } else {
            
            self.str_no_contact_on_delivery = "0"
            self.btn_check_uncheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.btn_check_uncheck.tag = 0
            
        }
        
    }
    
}

//MARK:- TABLE VIEW -
extension UPDSCartList: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_cart_list_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDSCartListTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSCartListTableCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_cart_list_items[indexPath.row] as? [String:Any]
        
        if (item!["foodTag"] as! String) == "Veg" {
            cell.imgVegNonveg.image = UIImage(named: "veg")
        } else {
            cell.imgVegNonveg.image = UIImage(named: "non-veg")
        }
        
        cell.lblFoodName.text = (item!["foodName"] as! String)

        // cell.lbl_description.text = (item!["description"] as! String)
        
        let bigNumber = Double("\(item!["specialPrice"]!)")
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let formattedNumber = numberFormatter.string(from: bigNumber! as NSNumber)
        cell.lblRealPrice.text = "\(formattedNumber!)"
        
        cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        cell.imgFoodImage.sd_setImage(with: URL(string: (item!["foodImage"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        cell.stepper.value = Double("\(item!["quantity"]!)")!
        cell.stepper.tag = indexPath.row
        cell.stepper.addTarget(self, action: #selector(stepperValueChanged_2), for: .valueChanged)
        
        
        return cell
    }
    
    @objc func signInClickMethod() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSDashboardTwoId") as? UPDSDashboardTwo
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func dontHaveAntAccountClickMethod() {
        let settingsVCId = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegistraitonId") as? Registraiton
        self.navigationController?.pushViewController(settingsVCId!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}


class UPDSCartListTableCell: UITableViewCell {

    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var imgFoodImage:UIImageView! {
        didSet {
            imgFoodImage.layer.cornerRadius = 8
            imgFoodImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var stepper: GMStepper!
    
    @IBOutlet weak var lblFoodName:UILabel!
    
    @IBOutlet weak var lblRealPrice:UILabel!
    
    @IBOutlet weak var imgVegNonveg:UIImageView! {
           didSet {
               imgVegNonveg.backgroundColor = .clear
               
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
