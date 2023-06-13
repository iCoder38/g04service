//
//  UPSCCustomerTwoTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 02/11/21.
//

import UIKit

class UPSCCustomerTwoTableViewCell: UITableViewCell {
    
    let paddingFromLeftIs:CGFloat = 10
    
    @IBOutlet weak var txtFareMileageEstimate:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtFareMileageEstimate,
                              tfName: txtFareMileageEstimate.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Enter Price")*/
            
            txtFareMileageEstimate.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txtFareMileageEstimate.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txtFareMileageEstimate.layer.shadowOpacity = 1.0
            txtFareMileageEstimate.layer.shadowRadius = 4
            txtFareMileageEstimate.layer.masksToBounds = false
            txtFareMileageEstimate.layer.cornerRadius = 8
            txtFareMileageEstimate.backgroundColor = .white
            txtFareMileageEstimate.keyboardType = .decimalPad
            txtFareMileageEstimate.text = "0"
            txtFareMileageEstimate.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtEstimatedPrice:UITextField! {
        didSet {
           /* Utils.textFieldUI(textField: txtEstimatedPrice,
                              tfName: txtEstimatedPrice.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Enter Amount")*/
            
            txtEstimatedPrice.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txtEstimatedPrice.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txtEstimatedPrice.layer.shadowOpacity = 1.0
            txtEstimatedPrice.layer.shadowRadius = 4
            txtEstimatedPrice.layer.masksToBounds = false
            txtEstimatedPrice.layer.cornerRadius = 8
            txtEstimatedPrice.backgroundColor = .white
            txtEstimatedPrice.keyboardType = .decimalPad
            txtEstimatedPrice.text = "0"
            txtEstimatedPrice.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtTaxEstimate:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtTaxEstimate,
                              tfName: txtTaxEstimate.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Enter Amount")*/
            
            txtTaxEstimate.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txtTaxEstimate.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txtTaxEstimate.layer.shadowOpacity = 1.0
            txtTaxEstimate.layer.shadowRadius = 4
            txtTaxEstimate.layer.masksToBounds = false
            txtTaxEstimate.layer.cornerRadius = 8
            txtTaxEstimate.backgroundColor = .white
            txtTaxEstimate.keyboardType = .decimalPad
            txtTaxEstimate.text = "0"
            txtTaxEstimate.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtFareTimeEstimate:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtFareTimeEstimate,
                              tfName: txtFareTimeEstimate.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Enter Amount")*/
            
            txtFareTimeEstimate.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txtFareTimeEstimate.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txtFareTimeEstimate.layer.shadowOpacity = 1.0
            txtFareTimeEstimate.layer.shadowRadius = 4
            txtFareTimeEstimate.layer.masksToBounds = false
            txtFareTimeEstimate.layer.cornerRadius = 8
            txtFareTimeEstimate.backgroundColor = .white
            txtFareTimeEstimate.keyboardType = .decimalPad
            txtFareTimeEstimate.text = "0"
            txtFareTimeEstimate.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtTipAmount:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtTipAmount,
                              tfName: txtTipAmount.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Enter donation amount")*/
            
            txtTipAmount.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txtTipAmount.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txtTipAmount.layer.shadowOpacity = 1.0
            txtTipAmount.layer.shadowRadius = 4
            txtTipAmount.layer.masksToBounds = false
            txtTipAmount.layer.cornerRadius = 8
            txtTipAmount.backgroundColor = .white
            txtTipAmount.keyboardType = .decimalPad
            txtTipAmount.text = "0"
            txtTipAmount.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtViewNotes:UITextView!{
        didSet{
            txtViewNotes.layer.borderWidth = 1
            txtViewNotes.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            txtViewNotes.layer.cornerRadius = 8
            txtViewNotes.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnCheckUncheck:UIButton! {
        didSet {
            btnCheckUncheck.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var btnAmount:UIButton! {
        didSet {
            Utils.buttonStyle(button: btnAmount, bCornerRadius: 6, bBackgroundColor: .systemOrange, bTitle: "Total Amount: " + "$256.99", bTitleColor: .white)
        }
    }
    
    @IBOutlet weak var lbl:UILabel! {
        didSet {
            lbl.text = """
Will refund extra if under. Will reach out to
customer If need to deposit more. 10
Minutes wait if not available will get $5
Charge for the time
"""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
