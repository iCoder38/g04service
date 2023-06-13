//
//  RPCompleteProfileTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 24/11/21.
//

import UIKit

class RPCompleteProfileTableViewCell: UITableViewCell {
    
    let paddingFromLeftIs:CGFloat = 10
    
    @IBOutlet weak var txtStreetAddress:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtStreetAddress,
                              tfName: txtStreetAddress.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Street Address")
        }
    }
    
    @IBOutlet weak var txtCity:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtCity,
                              tfName: txtCity.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "City")
        }
    }
    
    @IBOutlet weak var txtState:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtState,
                              tfName: txtState.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "State")
        }
    }
    
    @IBOutlet weak var txtZipcode:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtZipcode,
                              tfName: txtZipcode.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Zipcode")
        }
    }
    
    @IBOutlet weak var txtCountry:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtCountry,
                              tfName: txtCountry.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Country")
        }
    }
    
    @IBOutlet weak var saveAndContinue:UIButton! {
        didSet {
            Utils.buttonStyle(button: saveAndContinue, bCornerRadius: 6, bBackgroundColor: .black, bTitle: "Save & Continue", bTitleColor: .white)
        }
    }
    
    @IBOutlet weak var viewCoverImage:UIView!{
        didSet{
            viewCoverImage.addDashBorder()
        }
    }
    @IBOutlet weak var viewLogo:UIView!{
        didSet{
            viewLogo.addDashBorder()
        }
    }
    
    @IBOutlet weak var btnUploadCoverImage:UIButton!{
        didSet{
            btnUploadCoverImage.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var btnUploadLogo:UIButton!{
        didSet{
            btnUploadLogo.setTitle("", for: .normal)
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
