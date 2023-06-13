//
//  UPSCOrderDetailsTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 03/11/21.
//

import UIKit

class UPSCOrderDetailsTableViewCell: UITableViewCell {

    let paddingFromLeftIs:CGFloat = 10
    
    @IBOutlet weak var txtProductname:UITextField! {
        didSet {
//             txtProductname.backgroundColor = .clear
            txtProductname.borderStyle = .none
            txtProductname.layer.masksToBounds = false
            txtProductname.layer.cornerRadius = 5.0;
            txtProductname.layer.backgroundColor = UIColor.white.cgColor
            txtProductname.layer.borderColor = UIColor.clear.cgColor
            txtProductname.layer.shadowColor = UIColor.black.cgColor
            txtProductname.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtProductname.layer.shadowOpacity = 0.2
            txtProductname.layer.shadowRadius = 4.0
            txtProductname.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txtStore:UITextField!{
        didSet{
            txtStore.borderStyle = .none
            txtStore.layer.masksToBounds = false
            txtStore.layer.cornerRadius = 5.0;
            txtStore.layer.backgroundColor = UIColor.white.cgColor
            txtStore.layer.borderColor = UIColor.clear.cgColor
            txtStore.layer.shadowColor = UIColor.black.cgColor
            txtStore.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtStore.layer.shadowOpacity = 0.2
            txtStore.layer.shadowRadius = 4.0
            txtStore.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txtEstimatedPrice:UITextField!{
        didSet{
            txtEstimatedPrice.borderStyle = .none
            txtEstimatedPrice.layer.masksToBounds = false
            txtEstimatedPrice.layer.cornerRadius = 5.0;
            txtEstimatedPrice.layer.backgroundColor = UIColor.white.cgColor
            txtEstimatedPrice.layer.borderColor = UIColor.clear.cgColor
            txtEstimatedPrice.layer.shadowColor = UIColor.black.cgColor
            txtEstimatedPrice.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEstimatedPrice.layer.shadowOpacity = 0.2
            txtEstimatedPrice.layer.shadowRadius = 4.0
            txtEstimatedPrice.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txtTip:UITextField!{
        didSet{
            txtTip.borderStyle = .none
            txtTip.layer.masksToBounds = false
            txtTip.layer.cornerRadius = 5.0;
            txtTip.layer.backgroundColor = UIColor.white.cgColor
            txtTip.layer.borderColor = UIColor.clear.cgColor
            txtTip.layer.shadowColor = UIColor.black.cgColor
            txtTip.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtTip.layer.shadowOpacity = 0.2
            txtTip.layer.shadowRadius = 4.0
            txtTip.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txtDeliveryFee:UITextField!{
        didSet{
            txtDeliveryFee.borderStyle = .none
            txtDeliveryFee.layer.masksToBounds = false
            txtDeliveryFee.layer.cornerRadius = 5.0;
            txtDeliveryFee.layer.backgroundColor = UIColor.white.cgColor
            txtDeliveryFee.layer.borderColor = UIColor.clear.cgColor
            txtDeliveryFee.layer.shadowColor = UIColor.black.cgColor
            txtDeliveryFee.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtDeliveryFee.layer.shadowOpacity = 0.2
            txtDeliveryFee.layer.shadowRadius = 4.0
            txtDeliveryFee.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txtServiceFee:UITextField!{
        didSet{
            txtServiceFee.borderStyle = .none
            txtServiceFee.layer.masksToBounds = false
            txtServiceFee.layer.cornerRadius = 5.0;
            txtServiceFee.layer.backgroundColor = UIColor.white.cgColor
            txtServiceFee.layer.borderColor = UIColor.clear.cgColor
            txtServiceFee.layer.shadowColor = UIColor.black.cgColor
            txtServiceFee.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtServiceFee.layer.shadowOpacity = 0.2
            txtServiceFee.layer.shadowRadius = 4.0
            txtServiceFee.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txtSpecialNote:UITextField!{
        didSet{
            txtSpecialNote.borderStyle = .none
            txtSpecialNote.layer.masksToBounds = false
            txtSpecialNote.layer.cornerRadius = 5.0;
            txtSpecialNote.layer.backgroundColor = UIColor.white.cgColor
            txtSpecialNote.layer.borderColor = UIColor.clear.cgColor
            txtSpecialNote.layer.shadowColor = UIColor.black.cgColor
            txtSpecialNote.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtSpecialNote.layer.shadowOpacity = 0.2
            txtSpecialNote.layer.shadowRadius = 4.0
            txtSpecialNote.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var viewDown:UIView!{
        didSet{
            viewDown.layer.borderWidth = 1
            viewDown.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            viewDown.layer.cornerRadius = 8
            viewDown.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txtViewComment:UITextView!
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var btn_status:UIButton! {
        didSet {
            btn_status.layer.masksToBounds = false
            btn_status.layer.cornerRadius = 5.0;
            btn_status.layer.backgroundColor = UIColor.white.cgColor
            btn_status.layer.borderColor = UIColor.clear.cgColor
            btn_status.layer.shadowColor = UIColor.black.cgColor
            btn_status.layer.shadowOffset = CGSize(width: 0, height: 0)
            btn_status.layer.shadowOpacity = 0.2
            btn_status.layer.shadowRadius = 4.0
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
