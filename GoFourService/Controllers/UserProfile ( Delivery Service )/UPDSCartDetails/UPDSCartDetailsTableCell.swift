//
//  UPDSCartDetailsTableCell.swift
//  GoFourService
//
//  Created by Apple on 03/03/21.
//

import UIKit

class UPDSCartDetailsTableCell: UITableViewCell {

    @IBOutlet weak var txtCouponCode:UITextField! {
        didSet {
            txtCouponCode.layer.cornerRadius = 8
            txtCouponCode.clipsToBounds = true
            txtCouponCode.backgroundColor = UIColor.init(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1)
            txtCouponCode.setLeftPaddingPoints(36)
            txtCouponCode.placeholder = "Coupon Code"
        }
    }
    
    @IBOutlet weak var btnApply:UIButton! {
        didSet {
            btnApply.layer.cornerRadius = 20
            btnApply.clipsToBounds = true
            btnApply.layer.borderColor = UIColor.lightGray.cgColor
            btnApply.layer.borderWidth = 0.6
        }
    }
    
    @IBOutlet weak var btnOne:UIButton! {
        didSet {
            btnOne.layer.cornerRadius = 8
            btnOne.clipsToBounds = true
            btnOne.layer.borderColor = UIColor.lightGray.cgColor
            btnOne.layer.borderWidth = 0.6
            btnOne.setTitle("$1", for: .normal)
            btnOne.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBOutlet weak var btnTwo:UIButton! {
        didSet {
            btnTwo.layer.cornerRadius = 8
            btnTwo.clipsToBounds = true
            btnTwo.layer.borderColor = UIColor.lightGray.cgColor
            btnTwo.layer.borderWidth = 0.6
            btnTwo.setTitle("$2", for: .normal)
            btnTwo.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBOutlet weak var btnThree:UIButton! {
        didSet {
            btnThree.layer.cornerRadius = 8
            btnThree.clipsToBounds = true
            btnThree.layer.borderColor = UIColor.lightGray.cgColor
            btnThree.layer.borderWidth = 0.6
            btnThree.setTitle("$3", for: .normal)
            btnThree.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBOutlet weak var btnCustom:UIButton! {
        didSet {
            btnCustom.layer.cornerRadius = 8
            btnCustom.clipsToBounds = true
            btnCustom.layer.borderColor = UIColor.lightGray.cgColor
            btnCustom.layer.borderWidth = 0.6
            btnCustom.setTitle(" Custom ", for: .normal)
            btnCustom.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBOutlet weak var btnRemoveTip:UIButton! {
        didSet {
            btnRemoveTip.isHidden = true
        }
    }
    
    @IBOutlet weak var clView:UICollectionView! {
        didSet {
            // clView.dataSource = self
            // clView.delegate = self
        }
    }
    
    @IBOutlet weak var lblDeliveryFeeAndServieCharge:UILabel! {
        didSet {
            lblDeliveryFeeAndServieCharge.text = "Delivery Fee :$\(delivery_fee) | Service Fee : $\(service_fee)"
        }
    }
    
    @IBOutlet weak var lblSubTotalAmount:UILabel! {
        didSet {
            //lblSubTotalAmount.text = "$4.5"
        }
    }
    @IBOutlet weak var lblDeliveryFee:UILabel! {
        didSet {
            lblDeliveryFee.text = delivery_fee
        }
    }
    @IBOutlet weak var lblServiceFee:UILabel! {
        didSet {
            lblServiceFee.text = service_fee
        }
    }
    @IBOutlet weak var lblMembershipFee:UILabel! {
        didSet {
            lblMembershipFee.text = membership_fee
        }
    }
    @IBOutlet weak var lblTip:UILabel! {
        didSet {
            lblTip.text = "0.0"
        }
    }
    @IBOutlet weak var lblDonation:UILabel! {
        didSet {
            lblDonation.text = donation_fee
        }
    }
    @IBOutlet weak var lblTaxes:UILabel! {
        didSet {
            lblTaxes.text = taxes
        }
    }
    
    @IBOutlet weak var lblTotalAmount:UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
