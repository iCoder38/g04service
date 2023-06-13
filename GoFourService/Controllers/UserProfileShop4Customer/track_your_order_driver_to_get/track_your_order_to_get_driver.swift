//
//  track_your_order_to_get_driver.swift
//  GoFourService
//
//  Created by Dishant Rajput on 30/09/22.
//

import UIKit
import Alamofire

import CoreLocation
import MapKit

class track_your_order_to_get_driver: UIViewController {
    
    var dict_track_to_get_data:NSDictionary!
    
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
        
        //print(self.dict_track_to_get_data as Any)
        
        
        
    }
    
    @objc func mark_as_delivered() {
        
        let alert = NewYorkAlertController(title: String("Alert"), message: String("Mark as delivered ?"), style: .alert)
        
        let yes_delivered = NewYorkButton(title: "yes, delivered", style: .default) {
            _ in
             self.mark_as_Delivered_to_get_status_from_driver()
        }
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([yes_delivered , cancel])
        self.present(alert, animated: true)
        
    }

    @objc func mark_as_Delivered_to_get_status_from_driver() {
        self.view.endEditing(true)
        
        // self.scroll_to_bottom(table_view: self.tbleView)
        
        
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
         
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        
        let parameters = [
            "action"            : "togetrequeststatusupdate",
            "driverId"          : "\(self.dict_track_to_get_data["driverId"]!)",
            "togetRequestId"    : "\(self.dict_track_to_get_data["togetRequestId"]!)",
            "status"            : "5",
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
                }
            }
        
    }
    
    
}

//MARK:- TABLE VIEW -
extension track_your_order_to_get_driver: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:track_your_order_to_get_driver_table_cell = tableView.dequeueReusableCell(withIdentifier: "track_your_order_to_get_driver_table_cell") as! track_your_order_to_get_driver_table_cell
        
       // cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
         cell.lblName.text = (self.dict_track_to_get_data["StoreCity"] as! String)
         cell.lblAdrees.text = (self.dict_track_to_get_data["address"] as! String)
        
        
        
        
        
        return cell
    }
 
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
}


class track_your_order_to_get_driver_table_cell: UITableViewCell {
    
    @IBOutlet weak var map:MKMapView!
    
    @IBOutlet weak var viewCellbg:UIView!{
        didSet{
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            //viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
           viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false
            viewCellbg.backgroundColor = .white
            
           // viewCellbg.layer.borderWidth = 5
            //viewCellbg.layer.borderColor = UIColor(re
        }
    }
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var btnTextDriver:UIButton!{
        didSet{
            btnTextDriver.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var lblAdrees:UILabel!
    @IBOutlet weak var lblLandmark:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
