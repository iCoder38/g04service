//
//  ItemDetails.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/11/21.
//

import UIKit

class ItemDetails: UIViewController {
    
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
            
           // viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            //viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            //viewBg.layer.shadowOpacity = 1.0
            //viewBg.layer.shadowRadius = 15.0
            //viewBg.layer.masksToBounds = false
            viewBg.backgroundColor = .clear
            viewBg.layer.cornerRadius = 8
            viewBg.clipsToBounds = true
            //viewBg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            viewBg.layer.borderWidth = 1
            viewBg.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            viewBg.backgroundColor = .clear
    
        }
    }
    
    @IBOutlet weak var viewBgDown:UIView! {
        didSet {
            viewBgDown.layer.cornerRadius = 8
            viewBgDown.clipsToBounds = true
            //viewBgDown.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            viewBgDown.layer.borderWidth = 1
            viewBgDown.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            
            //viewBgDown.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            //viewBgDown.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            //viewBgDown.layer.shadowOpacity = 1.0
            //viewBgDown.layer.shadowRadius = 15.0
            //viewBgDown.layer.masksToBounds = false
            viewBgDown.backgroundColor = .clear
    
        }
    }
    
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
    
    let cellReuseIdentifier = "ItemDetailsTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var lblCCnumber:UILabel!
    @IBOutlet weak var imgCCtype:UIImageView!
    @IBOutlet weak var lblTipAmount:UILabel!
    @IBOutlet weak var btnConfirmOrder:UIButton!{
        didSet{
            btnConfirmOrder.setTitle("CONFIRM THIS ORDER", for: .normal)
            btnConfirmOrder.layer.cornerRadius = 10.0
            btnConfirmOrder.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    


}

//MARK:- TABLE VIEW -
extension ItemDetails: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ItemDetailsTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
       // cell.lblPrice.text = "Price: " + "$150.00"
       // cell.lblQuantity.text = "Qty: " + "1"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension ItemDetails: UITableViewDelegate {
    
}
