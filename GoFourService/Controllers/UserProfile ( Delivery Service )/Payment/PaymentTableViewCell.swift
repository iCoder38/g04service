//
//  PaymentTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 11/10/21.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtNameOnCard:UITextField! {
        didSet {
           
            txtNameOnCard.borderStyle = UITextField.BorderStyle.none
            txtNameOnCard.textAlignment = .center
            txtNameOnCard.keyboardType = .default
        }
    }
    @IBOutlet weak var txtCardNumber:UITextField! {
        didSet {
            
            txtCardNumber.borderStyle = UITextField.BorderStyle.none
            txtCardNumber.textAlignment = .center
            txtCardNumber.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var txtExpDate:UITextField! {
        didSet {
            
            txtExpDate.borderStyle = UITextField.BorderStyle.none
          txtExpDate.textAlignment = .center
            txtExpDate.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var txtCVV:UITextField! {
        didSet {
        
            txtCVV.borderStyle = UITextField.BorderStyle.none
            txtCVV.textAlignment = .center
            txtCVV.keyboardType = .numberPad
            txtCVV.isSecureTextEntry = true
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
