//
//  UPDSAddressTableCell.swift
//  GoFourService
//
//  Created by Apple on 04/03/21.
//

import UIKit

class UPDSAddressTableCell: UITableViewCell {

    @IBOutlet weak var clView:UICollectionView! {
        didSet {
            clView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var txtName:UITextField! {
        didSet {
            txtName.borderStyle = .none
            txtName.layer.masksToBounds = false
            txtName.layer.cornerRadius = 5.0;
            txtName.layer.backgroundColor = UIColor.white.cgColor
            txtName.layer.borderColor = UIColor.clear.cgColor
            txtName.layer.shadowColor = UIColor.black.cgColor
            txtName.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtName.layer.shadowOpacity = 0.2
            txtName.layer.shadowRadius = 4.0
            txtName.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtAddress:UITextField! {
        didSet {
            txtAddress.borderStyle = .none
            txtAddress.layer.masksToBounds = false
            txtAddress.layer.cornerRadius = 5.0;
            txtAddress.layer.backgroundColor = UIColor.white.cgColor
            txtAddress.layer.borderColor = UIColor.clear.cgColor
            txtAddress.layer.shadowColor = UIColor.black.cgColor
            txtAddress.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtAddress.layer.shadowOpacity = 0.2
            txtAddress.layer.shadowRadius = 4.0
            txtAddress.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtCity:UITextField! {
        didSet {
            txtCity.borderStyle = .none
            txtCity.layer.masksToBounds = false
            txtCity.layer.cornerRadius = 5.0;
            txtCity.layer.backgroundColor = UIColor.white.cgColor
            txtCity.layer.borderColor = UIColor.clear.cgColor
            txtCity.layer.shadowColor = UIColor.black.cgColor
            txtCity.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtCity.layer.shadowOpacity = 0.2
            txtCity.layer.shadowRadius = 4.0
            txtCity.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtState:UITextField! {
        didSet {
            txtState.borderStyle = .none
            txtState.layer.masksToBounds = false
            txtState.layer.cornerRadius = 5.0;
            txtState.layer.backgroundColor = UIColor.white.cgColor
            txtState.layer.borderColor = UIColor.clear.cgColor
            txtState.layer.shadowColor = UIColor.black.cgColor
            txtState.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtState.layer.shadowOpacity = 0.2
            txtState.layer.shadowRadius = 4.0
            txtState.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtZipcode:UITextField! {
        didSet {
            txtZipcode.borderStyle = .none
            txtZipcode.layer.masksToBounds = false
            txtZipcode.layer.cornerRadius = 5.0;
            txtZipcode.layer.backgroundColor = UIColor.white.cgColor
            txtZipcode.layer.borderColor = UIColor.clear.cgColor
            txtZipcode.layer.shadowColor = UIColor.black.cgColor
            txtZipcode.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtZipcode.layer.shadowOpacity = 0.2
            txtZipcode.layer.shadowRadius = 4.0
            txtZipcode.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtPhone:UITextField! {
        didSet {
            txtPhone.borderStyle = .none
            txtPhone.layer.masksToBounds = false
            txtPhone.layer.cornerRadius = 5.0;
            txtPhone.layer.backgroundColor = UIColor.white.cgColor
            txtPhone.layer.borderColor = UIColor.clear.cgColor
            txtPhone.layer.shadowColor = UIColor.black.cgColor
            txtPhone.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtPhone.layer.shadowOpacity = 0.2
            txtPhone.layer.shadowRadius = 4.0
            txtPhone.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtLandmark:UITextField! {
        didSet {
            txtLandmark.borderStyle = .none
            txtLandmark.layer.masksToBounds = false
            txtLandmark.layer.cornerRadius = 5.0;
            txtLandmark.layer.backgroundColor = UIColor.white.cgColor
            txtLandmark.layer.borderColor = UIColor.clear.cgColor
            txtLandmark.layer.shadowColor = UIColor.black.cgColor
            txtLandmark.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtLandmark.layer.shadowOpacity = 0.2
            txtLandmark.layer.shadowRadius = 4.0
            txtLandmark.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txtViewAntSpecialNote:UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
