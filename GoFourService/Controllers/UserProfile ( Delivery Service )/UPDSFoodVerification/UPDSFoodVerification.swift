//
//  UPDSFoodVerification.swift
//  GoFourService
//
//  Created by Dishant Rajput on 20/10/21.
//

import UIKit
import SDWebImage

class UPDSFoodVerification: UIViewController {
    
    var dict_get_price_taxes_details:NSDictionary!
    var str_get_special_not_from_payment:String!
    var str_total_amount_after_tax:String!
    var arr_mut_food_item:NSMutableArray! = []
    
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
    
    let cellReuseIdentifier = "FoodVerificationTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lblNumOfItems:UILabel!
    
    @IBOutlet weak var btnPlaceOrder:UIButton! {
        didSet {
            btnPlaceOrder.backgroundColor = NAVIGATION_COLOR
            btnPlaceOrder.setTitle("Confirm", for: .normal)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        self.btnBack.addTarget(self, action: #selector(backClickMethod), for: .touchUpInside)
        self.btnPlaceOrder.addTarget(self, action: #selector(placeOrderClickMethod), for: .touchUpInside)
        
        print("=======> DISHANT RAJPUT <==========")
        print(self.dict_get_price_taxes_details as Any)
        print(self.str_get_special_not_from_payment as Any)
        print(self.str_total_amount_after_tax as Any)
        print(self.arr_mut_food_item as Any)
        print("=======> DISHANT RAJPUT <==========")
        
        self.lblNumOfItems.text = "\(self.arr_mut_food_item!) items"
        
        self.tbleView.delegate = self
        self.tbleView.dataSource = self
        self.tbleView.reloadData()
    }
    

    @objc func backClickMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- CONFIRM AND PAY -
    @objc func placeOrderClickMethod() {
        
        /*
         var dict_get_price_taxes_details_in_address:NSDictionary!
         var str_get_special_not_from_payment_in_address:String!
         var str_total_amount_after_tax_in_address:String!
         var arr_mut_food_item_in_address:NSMutableArray! = []
         */
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "address_id") as? address
        
        push!.dict_get_price_taxes_details_in_address = dict_get_price_taxes_details
        push!.str_get_special_not_from_payment_in_address = str_get_special_not_from_payment
        push!.str_total_amount_after_tax_in_address = str_total_amount_after_tax
        push!.arr_mut_food_item_in_address = arr_mut_food_item
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    
    
}

//MARK:- TABLE VIEW -
extension UPDSFoodVerification: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_food_item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDSFoodVerificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSFoodVerificationTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_mut_food_item[indexPath.row] as? [String:Any]
        
        cell.lblFoodName.text = (item!["name"] as! String)
        
        let bigNumber = Double(item!["price"] as! String)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let formattedNumber = numberFormatter.string(from: bigNumber! as NSNumber)
        cell.lblPrice.text = "\(formattedNumber!)"
        
        cell.lblQuantity.text = "Quantity : "+(item!["quantity"] as! String)
        
        if (item!["foodType"] as! String) == "Veg" {
            cell.imgVegNonveg.image = UIImage(named: "veg")
        } else {
            cell.imgVegNonveg.image = UIImage(named: "non-veg")
        }
        
        cell.imgFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        cell.imgFoodImage.sd_setImage(with: URL(string: (item!["foodImage"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        // cell.btn
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension UPDSFoodVerification: UITableViewDelegate {
    
}
