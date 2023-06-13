//
//  UPPCConfirmPayment.swift
//  GoFourService
//
//  Created by Dishant Rajput on 02/11/21.
//

import UIKit

class UPPCConfirmPayment: UIViewController {
    
     
    
    var get_dict_from_fare_section:NSDictionary!
    
    
    var str_save_donation_citizen:String! = "0"
    var str_save_donation_ministry:String! = "0"
    
     var str_total_amount:String! = "0"
    
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
                lblNavigationTitle.text = "Confirm"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
    
    
    //Donation Button(Citizen)
    
    @IBOutlet weak var btnOneCitizen:UIButton! {
        didSet {
            btnOneCitizen.layer.cornerRadius = 8
            btnOneCitizen.clipsToBounds = true
            btnOneCitizen.layer.borderColor = UIColor.lightGray.cgColor
            btnOneCitizen.layer.borderWidth = 0.6
            btnOneCitizen.setTitle("$1", for: .normal)
            btnOneCitizen.setTitleColor(.black, for: .normal)
            btnOneCitizen.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnTwoCitizen:UIButton! {
        didSet {
            btnTwoCitizen.layer.cornerRadius = 8
            btnTwoCitizen.clipsToBounds = true
            btnTwoCitizen.layer.borderColor = UIColor.lightGray.cgColor
            btnTwoCitizen.layer.borderWidth = 0.6
            btnTwoCitizen.setTitle("$2", for: .normal)
            btnTwoCitizen.setTitleColor(.black, for: .normal)
            btnTwoCitizen.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnThreeCitizen:UIButton! {
        didSet {
            btnThreeCitizen.layer.cornerRadius = 8
            btnThreeCitizen.clipsToBounds = true
            btnThreeCitizen.layer.borderColor = UIColor.lightGray.cgColor
            btnThreeCitizen.layer.borderWidth = 0.6
            btnThreeCitizen.setTitle("$3", for: .normal)
            btnThreeCitizen.setTitleColor(.black, for: .normal)
            btnThreeCitizen.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnCustomCitizen:UIButton! {
        didSet {
            btnCustomCitizen.layer.cornerRadius = 8
            btnCustomCitizen.clipsToBounds = true
            btnCustomCitizen.layer.borderColor = UIColor.lightGray.cgColor
            btnCustomCitizen.layer.borderWidth = 0.6
            btnCustomCitizen.setTitle(" Custom ", for: .normal)
            btnCustomCitizen.setTitleColor(.black, for: .normal)
            btnCustomCitizen.addTarget(self, action: #selector(btnCustomCitizenTapped), for: .touchUpInside)
        }
    }
    
    //Donation Button(Ministry)
    
    @IBOutlet weak var btnOneMinistry:UIButton! {
        didSet {
            btnOneMinistry.layer.cornerRadius = 8
            btnOneMinistry.clipsToBounds = true
            btnOneMinistry.layer.borderColor = UIColor.lightGray.cgColor
            btnOneMinistry.layer.borderWidth = 0.6
            btnOneMinistry.setTitle("$1", for: .normal)
            btnOneMinistry.setTitleColor(.black, for: .normal)
            btnOneMinistry.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnTwoMinistry:UIButton! {
        didSet {
            btnTwoMinistry.layer.cornerRadius = 8
            btnTwoMinistry.clipsToBounds = true
            btnTwoMinistry.layer.borderColor = UIColor.lightGray.cgColor
            btnTwoMinistry.layer.borderWidth = 0.6
            btnTwoMinistry.setTitle("$2", for: .normal)
            btnTwoMinistry.setTitleColor(.black, for: .normal)
            btnTwoMinistry.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnThreeMinistry:UIButton! {
        didSet {
            btnThreeMinistry.layer.cornerRadius = 8
            btnThreeMinistry.clipsToBounds = true
            btnThreeMinistry.layer.borderColor = UIColor.lightGray.cgColor
            btnThreeMinistry.layer.borderWidth = 0.6
            btnThreeMinistry.setTitle("$3", for: .normal)
            btnThreeMinistry.setTitleColor(.black, for: .normal)
            btnThreeMinistry.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnCustomMinistry:UIButton! {
        didSet {
            btnCustomMinistry.layer.cornerRadius = 8
            btnCustomMinistry.clipsToBounds = true
            btnCustomMinistry.layer.borderColor = UIColor.lightGray.cgColor
            btnCustomMinistry.layer.borderWidth = 0.6
            btnCustomMinistry.setTitle(" Custom ", for: .normal)
            btnCustomMinistry.setTitleColor(.black, for: .normal)
            btnCustomMinistry.addTarget(self, action: #selector(btnCustomCitizenTapped), for: .touchUpInside)
        }
    }

    @IBOutlet weak var lblMileageFee:UILabel!
    @IBOutlet weak var lblTimeFee:UILabel!
    @IBOutlet weak var lblSubtotal:UILabel!
    @IBOutlet weak var lblTip:UILabel!
    @IBOutlet weak var lblDonation:UILabel!
    @IBOutlet weak var lblGrand:UILabel!
    @IBOutlet weak var lblTotalFee:UILabel!
    
    @IBOutlet weak var btnConfirmPayment:UIButton!{
        didSet{
            btnConfirmPayment.setTitle("Confirm & Pay", for: .normal)
            btnConfirmPayment.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("=======> all values <=======")
        print(self.get_dict_from_fare_section as Any)
        print("=======> all values <=======")
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btnConfirmPayment.addTarget(self, action: #selector(confirm_pay_click_method), for: .touchUpInside)
        self.parse_all_value()
    }
    
    @objc func btnCustomCitizenTapped() {
        
        let alert = NewYorkAlertController.init(title: "Donation", message: "It's not the amount that matters but the meaning behind your donation!", style: .alert)

        alert.addTextField { tf in
            tf.placeholder = "Enter Tip Amount"
            tf.tag = 1
        }
        /*alert.addTextField { tf in
            tf.placeholder = "password"
            tf.tag = 2
        }*/

        let ok = NewYorkButton(title: "OK", style: .default) { [unowned alert] _ in
            alert.textFields.forEach { tf in
                let text = tf.text ?? ""
                switch tf.tag {
                case 1:
                    print("Enter Tip Amount: \(text)")
                //case 2:
                 //   print("password: \(text)")
                default:
                    break
                }
            }
        }
        let cancel = NewYorkButton(title: "Cancel", style: .cancel)
        alert.addButtons([ok, cancel])

        alert.isTapDismissalEnabled = false

        present(alert, animated: true)
    }
    
    
    @objc func parse_all_value() {
        
        /*
         @IBOutlet weak var lblMileageFee:UILabel!
         @IBOutlet weak var lblTimeFee:UILabel!
         @IBOutlet weak var lblSubtotal:UILabel!
         @IBOutlet weak var lblTip:UILabel!
         @IBOutlet weak var lblDonation:UILabel!
         @IBOutlet weak var lblGrand:UILabel!
         @IBOutlet weak var lblTotalFee:UILabel!
         */
        
        let remove_from_milage_fee = String((self.get_dict_from_fare_section["mileage_fee"] as! String).dropFirst(1))
        
        let remove_from_time_fee = String((self.get_dict_from_fare_section["fare_time_estimate"] as! String).dropFirst(1))
        
        let remove_from_tip = String((self.get_dict_from_fare_section["tip_amount"] as! String).dropFirst(1))
        
        // let remove_from_tax = String((self.get_dict_from_fare_section["tax_estimate"] as! String).dropFirst(1))
        // let remove_from_estimate = String((self.get_dict_from_fare_section["estimate_price"] as! String).dropFirst(1))
        
        self.lblMileageFee.text     = "$"+String(remove_from_milage_fee)
        self.lblTimeFee.text        = "$"+String(remove_from_time_fee)
        self.lblTip.text            = "$"+String(remove_from_tip)
        
        self.lblDonation.text = "$0"
        self.lblGrand.text = "$0"
        
        self.calculate_final_price()
        
        
        
        self.btnOneCitizen.addTarget(self, action: #selector(one_citizend_clicked_method), for: .touchUpInside)
        self.btnTwoCitizen.addTarget(self, action: #selector(two_citizend_clicked_method), for: .touchUpInside)
        self.btnThreeCitizen.addTarget(self, action: #selector(three_citizend_clicked_method), for: .touchUpInside)
        
        self.btnOneMinistry.addTarget(self, action: #selector(one_ministry_clicked_method), for: .touchUpInside)
        self.btnTwoMinistry.addTarget(self, action: #selector(two_ministry_clicked_method), for: .touchUpInside)
        self.btnThreeMinistry.addTarget(self, action: #selector(three_ministry_clicked_method), for: .touchUpInside)
        
    }
    
    // MARK: - CITIZEN ( ONE ) -
    @objc func one_citizend_clicked_method() {
        
        self.btnOneCitizen.backgroundColor = NAVIGATION_COLOR
        self.btnOneCitizen.setTitleColor(.white, for: .normal)
        
        self.btnTwoCitizen.backgroundColor = .white
        self.btnTwoCitizen.setTitleColor(.black, for: .normal)
        
        self.btnThreeCitizen.backgroundColor = .white
        self.btnThreeCitizen.setTitleColor(.black, for: .normal)
        
        
        self.lblDonation.text = "$1"
        self.str_save_donation_citizen = "1"
        
        self.calculate_final_price()
    }
    
    // MARK: - CITIZEN ( TWO ) -
    
    @objc func two_citizend_clicked_method() {
        
        self.btnTwoCitizen.backgroundColor = NAVIGATION_COLOR
        self.btnTwoCitizen.setTitleColor(.white, for: .normal)
        
        self.btnOneCitizen.backgroundColor = .white
        self.btnOneCitizen.setTitleColor(.black, for: .normal)
        
        self.btnThreeCitizen.backgroundColor = .white
        self.btnThreeCitizen.setTitleColor(.black, for: .normal)
        
        self.lblDonation.text = "$2"
        self.str_save_donation_citizen = "2"
        
        self.calculate_final_price()
    }
    
    // MARK: - CITIZEN ( THREE ) -
    @objc func three_citizend_clicked_method() {
        
        self.btnThreeCitizen.backgroundColor = NAVIGATION_COLOR
        self.btnThreeCitizen.setTitleColor(.white, for: .normal)
        
        self.btnOneCitizen.backgroundColor = .white
        self.btnOneCitizen.setTitleColor(.black, for: .normal)
        
        self.btnTwoCitizen.backgroundColor = .white
        self.btnTwoCitizen.setTitleColor(.black, for: .normal)
        
        self.lblDonation.text = "$3"
        self.str_save_donation_citizen = "3"
        
        self.calculate_final_price()
    }
    
    
    // MARK: - MINISTRY ( ONE ) -
    @objc func one_ministry_clicked_method() {
        
        self.btnOneMinistry.backgroundColor = NAVIGATION_COLOR
        self.btnOneMinistry.setTitleColor(.white, for: .normal)
        
        self.btnTwoMinistry.backgroundColor = .white
        self.btnTwoMinistry.setTitleColor(.black, for: .normal)
        
        self.btnThreeMinistry.backgroundColor = .white
        self.btnThreeMinistry.setTitleColor(.black, for: .normal)
        
        
        self.lblGrand.text = "$1"
        self.str_save_donation_ministry = "1"
        
        self.calculate_final_price()
    }
    
    // MARK: - MINISTRY ( TWO ) -
    
    @objc func two_ministry_clicked_method() {
        
        self.btnTwoMinistry.backgroundColor = NAVIGATION_COLOR
        self.btnTwoMinistry.setTitleColor(.white, for: .normal)
        
        self.btnOneMinistry.backgroundColor = .white
        self.btnOneMinistry.setTitleColor(.black, for: .normal)
        
        self.btnThreeMinistry.backgroundColor = .white
        self.btnThreeMinistry.setTitleColor(.black, for: .normal)
        
        self.lblGrand.text = "$2"
        self.str_save_donation_ministry = "2"
        
        self.calculate_final_price()
    }
    
    // MARK: - MINISTRY ( THREE ) -
    @objc func three_ministry_clicked_method() {
        
        self.btnThreeMinistry.backgroundColor = NAVIGATION_COLOR
        self.btnThreeMinistry.setTitleColor(.white, for: .normal)
        
        self.btnOneMinistry.backgroundColor = .white
        self.btnOneMinistry.setTitleColor(.black, for: .normal)
        
        self.btnTwoMinistry.backgroundColor = .white
        self.btnTwoMinistry.setTitleColor(.black, for: .normal)
        
        self.lblGrand.text = "$3"
        
        self.str_save_donation_ministry = "3"
        self.calculate_final_price()
    }
    
    // MARK: - CALCULATE FINAL PRICE -
    @objc func calculate_final_price() {
        let remove_from_milage_fee = String((self.get_dict_from_fare_section["mileage_fee"] as! String).dropFirst(1))
        
        let remove_from_time_fee = String((self.get_dict_from_fare_section["fare_time_estimate"] as! String).dropFirst(1))
        
        let remove_from_tip = String((self.get_dict_from_fare_section["tip_amount"] as! String).dropFirst(1))
        
        let remove_from_tax = String((self.get_dict_from_fare_section["tax_estimate"] as! String).dropFirst(1))
        
        let remove_from_estimate = String((self.get_dict_from_fare_section["estimate_price"] as! String).dropFirst(1))
        
        let double_price = Double(remove_from_milage_fee)!+Double(remove_from_time_fee)!+Double(remove_from_tip)!+Double(remove_from_tax)!+Double(remove_from_estimate)!+Double(self.str_save_donation_citizen)!+Double(self.str_save_donation_ministry)!
        
        let final_total: String = String(format: "%.2f", double_price)
        
        
        
        // for final
        self.lblTotalFee.text = "Total Amount : $"+String(final_total)
        
        
        // subtotal without donation
        let double_price_sub = Double(remove_from_milage_fee)!+Double(remove_from_time_fee)!+Double(remove_from_tip)!+Double(remove_from_tax)!+Double(remove_from_estimate)!
        
        let final_total_sub: String = String(format: "%.2f", double_price_sub)
        
        self.lblSubtotal.text = "$"+String(final_total_sub)
        
        self.str_total_amount = String(final_total_sub)
    }
    
    @objc func confirm_pay_click_method() {
        
        // get_dict_from_fare_section
        
        /*
         "estimate_price" = 025;
         "fare_time_estimate" = 052;
         "mileage_fee" = 010;
         "store_you_live" = "Ha ye sahi mein ";
         "tax_estimate" = 012;
         "tip_amount" = 02;
         "what_would_you_like" = Test;
         */
        
        let remove_from_milage_fee = String((self.get_dict_from_fare_section["mileage_fee"] as! String).dropFirst(1))
        
        let remove_from_time_fee = String((self.get_dict_from_fare_section["fare_time_estimate"] as! String).dropFirst(1))
        
        let remove_from_tip = String((self.get_dict_from_fare_section["tip_amount"] as! String).dropFirst(1))
        
        let remove_from_tax = String((self.get_dict_from_fare_section["tax_estimate"] as! String).dropFirst(1))
        
        let remove_from_estimate = String((self.get_dict_from_fare_section["estimate_price"] as! String).dropFirst(1))
        
        let custom_dict = [
            "estimate_price"        : String(remove_from_estimate),
            "fare_time_estimate"    : String(remove_from_time_fee),
            "mileage_fee"           : String(remove_from_milage_fee),
            "store_you_live"        : (self.get_dict_from_fare_section["store_you_live"] as! String),
            "tax_estimate"          : String(remove_from_tax),
            "tip_amount"            : String(remove_from_tip),
            "what_would_you_like"   : (self.get_dict_from_fare_section["what_would_you_like"] as! String),
            "total_amount"          : String(self.str_total_amount),
        ]
        
        // address
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "to_get_address_id") as? to_get_address
        
        push!.dict_get_full_data_of_to_get_for_payment = custom_dict as NSDictionary
        
        self.navigationController?.pushViewController(push!, animated: true)
    }

}
