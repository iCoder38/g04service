//
//  UPDSCartDetails.swift
//  GoFourService
//
//  Created by Apple on 03/03/21.
//

import UIKit

class UPDSCartDetails: UIViewController, UITextFieldDelegate {

    var str_no_contact_on_delivery:String!
    
    //var str_get_tip_amount_from_cart_details:
    var str_get_special_note_from_cart:String!
    var str_sub_toal_amount:String!
    var arr_mut_get_cart_list:NSMutableArray! = []
    
    var str_tip_amount_user_selected:String! = "0"
    var str_total_price_after_taxes:String! = "0"
    
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
                lblNavigationTitle.text = CART_LIST_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let selectColor = UIColor.systemTeal // UIColor.init(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1)
    
    let cellReuseIdentifier = "uPDSCartDetailsTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(backClickMethod), for: .touchUpInside)
        self.btnPlaceOrder.addTarget(self, action: #selector(reviewYourOrderClickMethod), for: .touchUpInside)
        
        
        self.tbleView.separatorColor = .clear
        
        
        let index = IndexPath(row: 0, section: 0)
        self.tbleView.scrollToRow(at: index, at: .bottom, animated: true)

        print(self.arr_mut_get_cart_list as Any)
        print(String(self.str_sub_toal_amount))
        
        print(self.str_no_contact_on_delivery as Any)
        
        self.calculationReceipt(strTipAmount: "0")
        
        // cell.lblSubTotalAmount.
    }
    
    @objc func backClickMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnTipButton() {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
    }
    
    
    /*@objc func btnTipClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        
        if cell.btnOne.titleLabel?.text == "$1" {
            print("$1")
        } else if cell.btnTwo.titleLabel?.text == "$2" {
            print("$2")
        } else if cell.btnThree.titleLabel?.text == "$3" {
            print("$3")
        } else if cell.btnCustom.titleLabel?.text == "Custom" {
            print("$3")
        } else {
            print("$4")
        }
        
        
        
    }*/
    
    
    @objc func btnTipOneClickMethod() {
        self.view.endEditing(true)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        
        cell.btnOne.backgroundColor = selectColor
        cell.btnTwo.backgroundColor = .white
        cell.btnThree.backgroundColor = .white
        cell.btnCustom.backgroundColor = .white
        cell.btnCustom.setTitle(" Custom ", for: .normal)
        
        cell.btnOne.setTitleColor(.white, for: .normal)
        cell.btnTwo.setTitleColor(.black, for: .normal)
        cell.btnThree.setTitleColor(.black, for: .normal)
        cell.btnCustom.setTitleColor(.black, for: .normal)
        
        cell.btnRemoveTip.isHidden = false
        
        // set tip value to tip text
        cell.lblTip.text = "1.0"
        self.calculationReceipt(strTipAmount: "1.0")
     }
    
    @objc func btnTipTwoClickMethod() {
        self.view.endEditing(true)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        cell.btnOne.backgroundColor = .white
        cell.btnTwo.backgroundColor = selectColor
        cell.btnThree.backgroundColor = .white
        cell.btnCustom.backgroundColor = .white
        cell.btnCustom.setTitle(" Custom ", for: .normal)
        
        cell.btnOne.setTitleColor(.black, for: .normal)
        cell.btnTwo.setTitleColor(.white, for: .normal)
        cell.btnThree.setTitleColor(.black, for: .normal)
        cell.btnCustom.setTitleColor(.black, for: .normal)
        
        cell.btnRemoveTip.isHidden = false
        
        // set tip value to tip text
        cell.lblTip.text = "2.0"
        self.calculationReceipt(strTipAmount: "2.0")
    }
    
    @objc func btnTipThreeClickMethod() {
        self.view.endEditing(true)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        cell.btnOne.backgroundColor = .white
        cell.btnTwo.backgroundColor = .white
        cell.btnThree.backgroundColor = selectColor
        cell.btnCustom.backgroundColor = .white
        cell.btnCustom.setTitle(" Custom ", for: .normal)
        
        cell.btnOne.setTitleColor(.black, for: .normal)
        cell.btnTwo.setTitleColor(.black, for: .normal)
        cell.btnThree.setTitleColor(.white, for: .normal)
        cell.btnCustom.setTitleColor(.black, for: .normal)
        
        cell.btnRemoveTip.isHidden = false
        
        // set tip value to tip text
        cell.lblTip.text = "3.0"

        self.calculationReceipt(strTipAmount: "3.0")
        
    }
    
    @objc func btnTipFourClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        cell.btnOne.backgroundColor = .white
        cell.btnTwo.backgroundColor = .white
        cell.btnThree.backgroundColor = .white
        cell.btnCustom.backgroundColor = selectColor
        
        cell.btnOne.setTitleColor(.black, for: .normal)
        cell.btnTwo.setTitleColor(.black, for: .normal)
        cell.btnThree.setTitleColor(.black, for: .normal)
        cell.btnCustom.setTitleColor(.white, for: .normal)
        
        cell.btnRemoveTip.isHidden = false
        
        
        // alert with text field
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Tip Amount", message: "Please Enter Tip Amount.\n\nImportant : Tip should be greater than $0.1", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "tip amount..."
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
             let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField!.text ?? "")")
            
            cell.btnCustom.setTitle(" Custom ( "+String(textField!.text!)+" ) ", for: .normal)
            
            // set tip value to tip text
            cell.lblTip.text = /*"$"+*/String(textField!.text!)
            
            self.calculationReceipt(strTipAmount: /*"$"+*/String(textField!.text!))
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { (_) in
            
            self.allDeselect()
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func removeTipAmountClickMethod() {
        self.allDeselect()
        
    }
    
    // MARK:- DESELECT ALL TIP AMOUNT -
    @objc func allDeselect() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        cell.btnCustom.setTitle(" Custom ", for: .normal)
        cell.btnRemoveTip.isHidden = true
        
        cell.btnOne.backgroundColor = .white
        cell.btnTwo.backgroundColor = .white
        cell.btnThree.backgroundColor = .white
        cell.btnCustom.backgroundColor = .white
        
        cell.btnOne.setTitleColor(.black, for: .normal)
        cell.btnTwo.setTitleColor(.black, for: .normal)
        cell.btnThree.setTitleColor(.black, for: .normal)
        cell.btnCustom.setTitleColor(.black, for: .normal)
        
        // set tip value to tip text
        cell.lblTip.text = "0"
        self.calculationReceipt(strTipAmount: "0")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func reviewYourOrderClickMethod() {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
         let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSFoodVerification") as? UPDSFoodVerification
        
        let custom_dict = ["total_amount"   : String(self.str_total_price_after_taxes),
                           "delivery_fee"   : String(delivery_fee),
                           "service_fee"    : String(service_fee),
                           "membership_fee" : String(membership_fee),
                           "tip"            : String(self.str_tip_amount_user_selected),
                           "donation"       : String(donation_fee),
                           "taxes"          : String(taxes)]
        
        push!.dict_get_price_taxes_details = custom_dict as NSDictionary
        push!.str_get_special_not_from_payment = String(str_get_special_note_from_cart)
        push!.str_total_amount_after_tax = String(str_sub_toal_amount)
        push!.arr_mut_food_item = arr_mut_get_cart_list
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    
    // MARK:- CALCULATION GOES HERE -
    @objc func calculationReceipt(strTipAmount:String) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSCartDetailsTableCell
        
        print(strTipAmount as Any)
        
        // sub total amount
        let strippedTotalAmount = String(self.str_sub_toal_amount)//.dropFirst(1))
        let subTotalAmount = Double(strippedTotalAmount)
        print(subTotalAmount as Any)
        
        // delivery fee
        let strippedDeliveryFee = String(cell.lblDeliveryFee.text!)//.dropFirst(1))
        let DeliveryFee = Double(strippedDeliveryFee)
        print(DeliveryFee as Any)
        
        // service fee
        let strippedServiceFee = String(cell.lblServiceFee.text!)//.dropFirst(1))
        let ServiceFee = Double(strippedServiceFee)
        print(ServiceFee as Any)
        
        // membership fee
        let strippedMembershipFee = String(cell.lblMembershipFee.text!)//.dropFirst(1))
        let MembershipFee = Double(strippedMembershipFee)
        print(MembershipFee as Any)
        
        // tip
        let strippedTip = String(strTipAmount)//.dropFirst(1))
        let Tip = Double(strippedTip)
        print(Tip as Any)
        
        self.str_tip_amount_user_selected = "\(Tip!)"
        
        // donation
        let strippedDonation = String(cell.lblDonation.text!)//.dropFirst(1))
        let Donation = Double(strippedDonation)
        print(Donation as Any)
        
        //  taxes
        let strippedTaxes = String(cell.lblTaxes.text!)//.dropFirst(1))
        let Taxes = Double(strippedTaxes)
        print(Taxes as Any)
        
        // result
        let totalResult = subTotalAmount!+DeliveryFee!+ServiceFee!+MembershipFee!+Tip!+Donation!+Taxes!
        print(totalResult as Any)
        
        
        cell.lblTotalAmount.text = /*"$"+*/String(format:"%.02f", totalResult)
        
        self.str_total_price_after_taxes = String(totalResult)
        
        let bigNumber = Double(totalResult)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let formattedNumber = numberFormatter.string(from: bigNumber as NSNumber)
        // cell.lblRealPrice.text = "\(formattedNumber!)"
        
        self.btnPlaceOrder.setTitle("Place order : \(formattedNumber!)", for: .normal)
        
        
        // self.btnPlaceOrder.setTitle("Place order ( "+String(cell.lblTotalAmount.text!)+" )", for: .normal)
    }
}


//MARK:- TABLE VIEW -
extension UPDSCartDetails: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let cell = cell as? UPDSCartDetailsTableCell {

            cell.clView.dataSource = self
            cell.clView.delegate = self
            cell.clView.tag = indexPath.section
            cell.clView.reloadData()

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDSCartDetailsTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSCartDetailsTableCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txtCouponCode.delegate = self
        
        cell.lblSubTotalAmount.text = String(self.str_sub_toal_amount)
        
        cell.btnOne.addTarget(self, action: #selector(btnTipOneClickMethod), for: .touchUpInside)
        cell.btnTwo.addTarget(self, action: #selector(btnTipTwoClickMethod), for: .touchUpInside)
        cell.btnThree.addTarget(self, action: #selector(btnTipThreeClickMethod), for: .touchUpInside)
        cell.btnCustom.addTarget(self, action: #selector(btnTipFourClickMethod), for: .touchUpInside)
        cell.btnRemoveTip.addTarget(self, action: #selector(removeTipAmountClickMethod), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 652
    }
    
}

extension UPDSCartDetails: UITableViewDelegate {
    
}


//MARK:- COLLECTION VIEW -
extension UPDSCartDetails: UICollectionViewDelegate {
    //Write Delegate Code Here
    
}

extension UPDSCartDetails: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "donationCollectionCell", for: indexPath as IndexPath) as! DonationCollectionCell
            
        cell.layer.cornerRadius = 16
        cell.clipsToBounds = true
        cell.backgroundColor = .white
        
        cell.lblDonationTitleName.text = " NGO : "+String(indexPath.row)+" "
        
        return cell
        
    }
   
    //Write DataSource Code Here
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
}

extension UPDSCartDetails: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // if collectionView == clView {
            
         var sizes: CGSize
        // let result = UIScreen.main.bounds.size
         
        // if result.height == 480 {
                //Load 3.5 inch xib
        sizes = CGSize(width: 128.0, height: 34.0)
        /*}
        else if result.height == 568 {
                //Load 4 inch xib
            sizes = CGSize(width: 100.0, height: 80.0)
        }
        else if result.height == 667.000000 {
                //Load 4.7 inch xib , 8
            sizes = CGSize(width: 180.0, height: 216.0) // done
        }
        else if result.height == 736.000000 {
                // iphone 6s Plus and 7 Plus
            sizes = CGSize(width: 180.0, height: 216.0) // done
        }
        else if result.height == 812.000000 {
                // iphone X , 11 pro
            sizes = CGSize(width: 160.0, height: 216.0) // done
        }
        else if result.height == 896.000000 {
                // iphone Xr ,11, 11 pro max
            sizes = CGSize(width: 180.0, height: 216.0) // done
        }
        else {
            sizes = CGSize(width: 114.0, height: 216.0)
        }*/
            
        
         return sizes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
