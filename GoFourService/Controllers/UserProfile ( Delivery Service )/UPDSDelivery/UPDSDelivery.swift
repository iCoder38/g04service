//
//  UPDSDelivery.swift
//  GoFourService
//
//  Created by Dishant Rajput on 21/10/21.
//

import UIKit

class UPDSDelivery: UIViewController {
    
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
    
    @IBOutlet weak var viewBg:UIView! {
        didSet {
            //viewCellbg.layer.cornerRadius = 8
            //viewCellbg.clipsToBounds = true
            //viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBg.layer.shadowOpacity = 1.0
            viewBg.layer.shadowRadius = 15.0
            viewBg.layer.masksToBounds = false
            //viewCellbg.backgroundColor = .clear
    
        }
    }
    
    let cellReuseIdentifier = "DeliveryTableCell"
    
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
    


}

//MARK:- TABLE VIEW -
extension UPDSDelivery: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDSDeliveryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSDeliveryTableViewCell
        
        //cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
       // cell.lblPrice.text = "Price: " + "$150.00"
        //cell.lblQuantity.text = "Qty: " + "1"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
    
}

extension UPDSDelivery: UITableViewDelegate {
    
}


