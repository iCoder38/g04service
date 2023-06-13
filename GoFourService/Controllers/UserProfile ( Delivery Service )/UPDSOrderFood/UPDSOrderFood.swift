//
//  UPDSOrderFood.swift
//  GoFourService
//
//  Created by Apple on 04/01/21.
//

import UIKit
import Alamofire
import SDWebImage

class UPDSOrderFood: UIViewController {
    
    var arr_mut_restaurant_list:NSMutableArray! = []
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var navigationBar:UIView! {
        didSet {
            navigationBar.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var btnBack:UIButton! {
        didSet {
            btnBack.tintColor = NAVIGATION_BACK_COLOR
            btnBack.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        }
    }
    
    @IBOutlet weak var lblNavigationTitle:UILabel! {
        didSet {
            lblNavigationTitle.text = ORDER_FOOD_PAGE_NAVIGATION_TITLE
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "uPDSOrderFoodTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.tbleView.separatorColor = .clear
        
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! PDCompleteAddressDetailsTableCell
        
        self.list_of_all_restaurants()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    // MARK: - ( WEBSERVICE )LOGIN -
    @objc func list_of_all_restaurants() {
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
                "action"    : "userlist",
                "userId"    : String(myString),
                "TYPE"      : "Restaurant",
                "pageNo"    : "",
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
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_restaurant_list.addObjects(from: ar as! [Any])
                                
                                
                                
                                
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
                            
                            self.please_check_your_internet_connection()
                            
                            return
                        }
                        
                    } catch _ {
                        print("Exception!")
                    }
                }
        }
    }
    
}

//MARK:- TABLE VIEW -
extension UPDSOrderFood: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_restaurant_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UPDSOrderFoodTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSOrderFoodTableCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_mut_restaurant_list[indexPath.row] as? [String:Any]
        cell.lblFoodName.text = (item!["fullName"] as! String)
        
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
        
        cell.imgFoodProfileImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        cell.imgFoodProfileImage.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_mut_restaurant_list[indexPath.row] as? [String:Any]
        //
        let settingsVCId = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPSDOrderDetailsId") as? UPSDOrderDetails
        settingsVCId!.str_restaurant_id = "\(item!["userId"]!)"
        self.navigationController?.pushViewController(settingsVCId!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
}

extension UPDSOrderFood: UITableViewDelegate {
    
}
