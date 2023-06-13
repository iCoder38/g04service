//
//  UPDSFoodOrderDetails.swift
//  GoFourService
//
//  Created by Apple on 08/03/21.
//

import UIKit
import MapKit

class UPDSFoodOrderDetails: UIViewController {

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
                lblNavigationTitle.text = FOOD_ORDER_DETAILS_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "UPDSFoodPlacedOrderTableCell"
    
    @IBOutlet weak var viewWhiteBg:UIView! {
        didSet {
            viewWhiteBg.layer.cornerRadius = 8
            viewWhiteBg.clipsToBounds = true
            viewWhiteBg.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var btnOrderPlaced:UIButton! {
        didSet {
            btnOrderPlaced.backgroundColor = .systemGreen
            btnOrderPlaced.layer.cornerRadius = 6
            btnOrderPlaced.clipsToBounds = true
            btnOrderPlaced.setTitle("ORDER PLACED", for: .normal)
        }
    }
    
    @IBOutlet weak var btnOrderList:UIButton!
    
    @IBOutlet weak var mapView:MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 6
            mapView.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.view.backgroundColor = UIColor.init(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        
        self.btnBack.addTarget(self, action: #selector(backClickMethod), for: .touchUpInside)
    }
    
    @objc func backClickMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK:- TABLE VIEW -
extension UPDSFoodOrderDetails: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDSFoodPlacedOrderTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSFoodPlacedOrderTableCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension UPDSFoodOrderDetails: UITableViewDelegate {
    
}
