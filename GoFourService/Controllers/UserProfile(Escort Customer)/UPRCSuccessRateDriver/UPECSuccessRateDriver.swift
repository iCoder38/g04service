//
//  UPECSuccessRateDriver.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/10/21.
//

import UIKit
import Alamofire
import SDWebImage

class UPECSuccessRateDriver: UIViewController {
    
    var str_star_check_status:String! = "0"
    
    var dict_get_driver_details_for_review:NSDictionary!
    
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
            lblNavigationTitle.text = "PAYMENT SUCCESS"
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var viewHeading:UIView!{
        didSet {
            viewHeading.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var lblTotalAmount:UILabel!
    @IBOutlet weak var lblDateTime:UILabel!
    
    let cellReuseIdentifier = "SuccessRateDriverTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        
        
    }
    
    @objc func star_one_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
        self.str_star_check_status = "1"
        
        cell.btn_star_one.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_two.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_three.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_four.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_five.setImage(UIImage(systemName: "star"), for: .normal)
        
    }
    
    @objc func star_two_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
        self.str_star_check_status = "2"
        
        cell.btn_star_one.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_two.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_three.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_four.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_five.setImage(UIImage(systemName: "star"), for: .normal)
        
    }
    
    @objc func star_three_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
        self.str_star_check_status = "3"
        
        cell.btn_star_one.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_two.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_three.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_four.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_five.setImage(UIImage(systemName: "star"), for: .normal)
        
    }
    
    @objc func star_four_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
        self.str_star_check_status = "4"
        
        cell.btn_star_one.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_two.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_three.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_four.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_five.setImage(UIImage(systemName: "star"), for: .normal)
        
    }
    
    @objc func star_five_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
        self.str_star_check_status = "5"
        
        cell.btn_star_one.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_two.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_three.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_four.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.btn_star_five.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
    }
    
    @objc func validation_before_submit_review() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
        if self.str_star_check_status == "0" {
            
        } else {
            
            if cell.txtViewComment.text == "" {
                
            } else {
                self.submit_review_WB()
            }
            
        }
        
        
    }
    
    @objc func submit_review_WB() {
        self.view.endEditing(true)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPECSuccessRateDriverTableViewCell
        
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
                "action"        : "submitreview",
                "reviewTo"      : "\(self.dict_get_driver_details_for_review["driverId"]!)",
                "reviewFrom"    : String(myString),
                "star"          : String(self.str_star_check_status),
                "message"       : String(cell.txtViewComment.text!),
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
                                
                                let alert = NewYorkAlertController(title: String("Success").uppercased(), message: String(str_data_message), style: .alert)
                                let cancel = NewYorkButton(title: "Ok", style: .cancel)
                                alert.addButtons([cancel])
                                self.present(alert, animated: true)
                                
                                if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                                    print(person as Any)
                                    
                                    if person["role"] as! String == "Member" {
                                         
                                        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSDashboardId")
                                        self.navigationController?.pushViewController(push, animated: true)
                                        
                                    }
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
                            
                            ERProgressHud.sharedInstance.hide()
                            self.please_check_your_internet_connection()
                            
                            return
                        }
                        
                    } catch _ {
                        print("Exception!")
                        ERProgressHud.sharedInstance.hide()
                        // print(response.error)
                        // print(response.error?.localizedDescription)
                    }
                }
        }
    }
    
}
//MARK:- TABLE VIEW -
extension UPECSuccessRateDriver: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPECSuccessRateDriverTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPECSuccessRateDriverTableViewCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
                
        cell.lblStartingLocation.text = (self.dict_get_driver_details_for_review["RequestPickupAddress"] as! String)
        cell.lblEndLocation.text = (self.dict_get_driver_details_for_review["driverAddress"] as! String)
        
        cell.imgDriver.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.imgDriver.sd_setImage(with: URL(string: (self.dict_get_driver_details_for_review["carImage"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        cell.lblDriverRating.text = "N.A."//"\(self.dict_get_driver_details_for_review["carImage"]!)"
        
        cell.lblDriverName.text = "\(self.dict_get_driver_details_for_review["driverName"]!)"
        
        cell.lblTotalTime.text = "\(self.dict_get_driver_details_for_review["totalTime"]!)"
        
        cell.btn_star_one.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_two.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_three.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_four.setImage(UIImage(systemName: "star"), for: .normal)
        cell.btn_star_five.setImage(UIImage(systemName: "star"), for: .normal)
        
        cell.btn_star_one.addTarget(self, action: #selector(star_one_click_method), for: .touchUpInside)
        cell.btn_star_two.addTarget(self, action: #selector(star_two_click_method), for: .touchUpInside)
        cell.btn_star_three.addTarget(self, action: #selector(star_three_click_method), for: .touchUpInside)
        cell.btn_star_four.addTarget(self, action: #selector(star_four_click_method), for: .touchUpInside)
        cell.btn_star_five.addTarget(self, action: #selector(star_five_click_method), for: .touchUpInside)
        
        self.lblTotalAmount.text = "$\(self.dict_get_driver_details_for_review["FinalFare"]!)"
        self.lblDateTime.text = "N.A."//"\(self.dict_get_driver_details_for_review["FinalFare"]!)"
        
        cell.btnNeedHelp.addTarget(self, action: #selector(validation_before_submit_review), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
}

extension UPECSuccessRateDriver: UITableViewDelegate {
    
}
