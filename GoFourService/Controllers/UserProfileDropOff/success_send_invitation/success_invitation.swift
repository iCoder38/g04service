//
//  success_invitation.swift
//  GoFourService
//
//  Created by Apple on 18/07/22.
//

import UIKit
import SwiftGifOrigin
import Alamofire

class success_invitation: UIViewController {
    
    //var secondsRemaining = 50
    var timer: Timer?
         var totalTime = 10
    
    var dict_get_all_add_booking_data:NSDictionary!
    
    @IBOutlet weak var indicators:UIActivityIndicatorView! {
        didSet {
            indicators.startAnimating()
        }
    }
    
    @IBOutlet weak var img_loader:UIImageView!
    
    @IBOutlet weak var btn_done:UIButton! {
        didSet {
            btn_done.isUserInteractionEnabled = false
            btn_done.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_done.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_done.layer.shadowOpacity = 1.0
            btn_done.layer.shadowRadius = 15.0
            btn_done.layer.masksToBounds = false
            btn_done.layer.cornerRadius = 6
            btn_done.backgroundColor = .white
            btn_done.setTitleColor(.black, for: .normal)
            btn_done.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var lbl_success_title:UILabel! {
        didSet {
            lbl_success_title.textColor = .black
            lbl_success_title.text = "Please wait...\n\n We will notify you if any driver accept your request."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gifAnimate()
        self.btn_done.addTarget(self, action: #selector(done_click_method), for: .touchUpInside)
        
        print(self.dict_get_all_add_booking_data as Any)
        
        self.add_booking_WB()
    }
    
    @objc func gifAnimate() {
        
        self.img_loader.image = UIImage.gif(name: "loading_gif")
        
    }
    
    // MARK: - PUSH ( BROWSE PRODUCT ) -
    @objc func done_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if person["role"] as! String == "Member" {
                
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSDashboardId") as? UPDSDashboard
                self.navigationController?.pushViewController(push!, animated: true)
                
            }
            
            
        }
        
        
    }
    
    @objc func add_booking_WB() {
        
//        self.totalTime = 60
//        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        // ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let params = add_booking_params(action: "addbooking",
                                            userId: String(myString),
                                            categoryId: (self.dict_get_all_add_booking_data["categoryId"] as! String),
                                            RequestPickupAddress: (self.dict_get_all_add_booking_data["RequestPickupAddress"] as! String),
                                            RequestPickupLatLong: (self.dict_get_all_add_booking_data["RequestPickupLatLong"] as! String),
                                            RequestDropAddress: (self.dict_get_all_add_booking_data["RequestDropAddress"] as! String),
                                            RequestDropLatLong: (self.dict_get_all_add_booking_data["RequestDropLatLong"] as! String),
                                            duration: (self.dict_get_all_add_booking_data["duration"] as! String),
                                            distance:(self.dict_get_all_add_booking_data["distance"] as! String),
                                            total: (self.dict_get_all_add_booking_data["total"] as! String))
            
            
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
                        
                        self.indicators.isHidden = true
                        self.indicators.stopAnimating()
                        self.btn_done.isUserInteractionEnabled = true
                        self.btn_done.setImage(UIImage(systemName: "arrow.right"), for: .normal)
                        self.btn_done.setTitle("", for: .normal)
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"] as? String
                        
                        self.img_loader.image = UIImage.gif(name: "alarm")
                        
                        self.indicators.isHidden = true
                        self.btn_done.isUserInteractionEnabled = true
                        self.btn_done.setImage(UIImage(systemName: "arrow.right"), for: .normal)
                        self.btn_done.setTitle("", for: .normal)
                        
                        self.lbl_success_title.text = "oh no...\n\n"+String(strSuccess2)
                        self.indicators.stopAnimating()
                        
                        /*let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String(strSuccess2), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)*/
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    self.please_check_your_internet_connection()
                    
                }
            }
        }
        
    }
    
    @objc func updateTimer() {
        
        if totalTime > 0 {
            print("\(totalTime) seconds.")
            totalTime -= 1
            
            self.btn_done.setImage(UIImage(systemName: ""), for: .normal)
            self.btn_done.setTitle("\(totalTime)", for: .normal)
            
        } else {
            self.timer?.invalidate()
            
            indicators.stopAnimating()
            self.btn_done.isUserInteractionEnabled = true
            self.btn_done.setTitle("", for: .normal)
            // self.btn_done.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        }
    }
    
}
