//
//  UPSCCustomerTwo.swift
//  GoFourService
//
//  Created by Dishant Rajput on 02/11/21.
//

import UIKit

class UPSCCustomerTwo: UIViewController , UITextFieldDelegate {
    
    var str_total_amount:String! = "0"
    
    var get_dict_from_store_page:NSDictionary!
    
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
            lblNavigationTitle.text = "HOME"
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    let cellReuseIdentifier = "CustomerTwoTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var btnContinue: UIButton!{
        didSet{
            btnContinue.setTitle("CONTINUE", for: .normal)
            btnContinue.backgroundColor =  NAVIGATION_COLOR
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        print(self.get_dict_from_store_page as Any)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCCustomerTwoTableViewCell
        
        textField.resignFirstResponder();
        
        cell.btnAmount.setTitle("Total amount : $", for: .normal)
        
        return true
    }
    
    private func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
        print("me")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("0ne")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCCustomerTwoTableViewCell
        
        
        
        print("two")
        print(textField.text as Any)
        
        /*if textField == cell.txtTipAmount {
            
            cell.txtTipAmount.text = textField.text
            
            let result1 = String(cell.txtTipAmount.text!.dropFirst())
            cell.txtTipAmount.text = String(result1)
            
        }*/
        
        self.add_all_values()
        
    }
    
    @objc func add_all_values() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCCustomerTwoTableViewCell
        
        if cell.txtFareMileageEstimate.text! == "" {
            cell.txtFareMileageEstimate.text = "0"
        }
        
        if cell.txtEstimatedPrice.text! == "" {
            cell.txtEstimatedPrice.text = "0"
        }
        
        if cell.txtTaxEstimate.text! == "" {
            cell.txtTaxEstimate.text = "0"
        }
        
        if cell.txtFareTimeEstimate.text! == "" {
            cell.txtFareTimeEstimate.text = "0"
        }
        
        if cell.txtTipAmount.text! == "" {
            cell.txtTipAmount.text = "0"
        }
        
        // let result = (num > 0) ? "Positive Number" : "Negative Number"
        
        let add_all_values = Double(cell.txtFareMileageEstimate.text!)!+Double(cell.txtEstimatedPrice.text!)!+Double(cell.txtTaxEstimate.text!)!+Double(cell.txtFareTimeEstimate.text!)!+Double(cell.txtTipAmount.text!)!
        
        let final_total: String = String(format: "%.2f", add_all_values)
        
        
        self.str_total_amount = String(final_total)
        
        
        cell.btnAmount.setTitle("Total amount $"+String(final_total), for: .normal)
        
    }
    
    @objc func amount_click_method() {
         let indexPath = IndexPath.init(row: 0, section: 0)
         let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCCustomerTwoTableViewCell
        
        let custom_dict = [
            "store_you_live" : (self.get_dict_from_store_page["store_you_live"] as! String),
            "what_would_you_like" : (self.get_dict_from_store_page["what_would_you_like"] as! String),
            "mileage_fee" : String(cell.txtFareMileageEstimate.text!),
            "estimate_price" : String(cell.txtEstimatedPrice.text!),
            "tax_estimate" : String(cell.txtTaxEstimate.text!),
            "fare_time_estimate" : String(cell.txtFareTimeEstimate.text!),
            "tip_amount" : String(cell.txtTipAmount.text!),
            
            
        ]
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPPCConfirmPayment_id") as? UPPCConfirmPayment
        
        push!.get_dict_from_fare_section = custom_dict as NSDictionary
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
}

//MARK:- TABLE VIEW -
extension UPSCCustomerTwo: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPSCCustomerTwoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPSCCustomerTwoTableViewCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txtFareMileageEstimate.delegate = self
        cell.txtEstimatedPrice.delegate = self
        cell.txtTaxEstimate.delegate = self
        cell.txtFareTimeEstimate.delegate = self
        cell.txtTipAmount.delegate = self
        
        cell.btnAmount.addTarget(self, action: #selector(amount_click_method), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1200
    }
    
}

extension UPSCCustomerTwo: UITableViewDelegate {
    
}
