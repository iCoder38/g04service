//
//  OrderUpdateDriver.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/11/21.
//

import UIKit
import MapKit
import CoreLocation

class OrderUpdateDriver: UIViewController {
    
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
                lblNavigationTitle.text = FOODVERIFICATION_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    @IBOutlet weak var lblStatus:UILabel!
    @IBOutlet weak var map:MKMapView!
    
    @IBOutlet weak var btnItemDetail:UIButton!{
        didSet{
            btnItemDetail.setTitle("ITEM DETAILS", for: .normal)
        }
    }
    
    @IBOutlet weak var btnDeliveryDetail:UIButton!{
        didSet{
            btnDeliveryDetail.setTitle("DELIVERY DETAILS", for: .normal)
        }
    }
    
    @IBOutlet weak var btnStatus:UIButton!{
        didSet{
            btnStatus.setTitle("Select Status", for: .normal)
            btnStatus.layer.cornerRadius = 17.0
            btnStatus.clipsToBounds = true
            btnStatus.addTarget(self, action: #selector(btnStatusTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var viewBottom:UIView!{
        didSet{
            viewBottom.clipsToBounds = true
            viewBottom.layer.cornerRadius = 8.0
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @objc func btnStatusTapped(){
        let actionSheet = NewYorkAlertController(title: "Select Status", message: "Please Select Current Status", style: .actionSheet)

        let titles = ["Driver is enroute", "Driver has arrived at restaurant"]
        
        actionSheet.addButtons(
            titles.enumerated().map { index, title -> NewYorkButton in
                let button = NewYorkButton(title: title, style: .default) { button in
                    print("Selected \(titles[button.tag])")
                    self.lblStatus.text = "Current Status: " + titles[button.tag]
                }
                button.tag = index
                button.setDynamicColor(.orange)
                return button
            }
        )

        let cancel = NewYorkButton(title: "Cancel", style: .cancel)
        actionSheet.addButton(cancel)

        present(actionSheet, animated: true)
    }

}
