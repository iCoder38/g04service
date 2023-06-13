//
//  UPDSDashboardTwoTableCell.swift
//  GoFourService
//
//  Created by Apple on 04/01/21.
//

import UIKit

class UPDSDashboardTwoTableCell: UITableViewCell {

    let paddingFromLeftIs:CGFloat = 10
    
    @IBOutlet weak var lblDashboardTwo:UILabel!
    
    @IBOutlet weak var btnEstimatedDate:UIButton!
    @IBOutlet weak var txtEstimatedDate:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtEstimatedDate,
                              tfName: txtEstimatedDate.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Estimated Date")*/
            
            txtEstimatedDate.borderStyle = .none
            txtEstimatedDate.layer.masksToBounds = false
            txtEstimatedDate.layer.cornerRadius = 5.0;
            txtEstimatedDate.layer.backgroundColor = UIColor.white.cgColor
            txtEstimatedDate.layer.borderColor = UIColor.clear.cgColor
            txtEstimatedDate.layer.shadowColor = UIColor.black.cgColor
            txtEstimatedDate.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEstimatedDate.layer.shadowOpacity = 0.2
            txtEstimatedDate.layer.shadowRadius = 4.0
            txtEstimatedDate.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btnEstimatedTime:UIButton!
    @IBOutlet weak var txtEstimatedTime:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtEstimatedTime,
                              tfName: txtEstimatedTime.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Estimated Time")*/
            
            txtEstimatedTime.borderStyle = .none
            txtEstimatedTime.layer.masksToBounds = false
            txtEstimatedTime.layer.cornerRadius = 5.0;
            txtEstimatedTime.layer.backgroundColor = UIColor.white.cgColor
            txtEstimatedTime.layer.borderColor = UIColor.clear.cgColor
            txtEstimatedTime.layer.shadowColor = UIColor.black.cgColor
            txtEstimatedTime.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEstimatedTime.layer.shadowOpacity = 0.2
            txtEstimatedTime.layer.shadowRadius = 4.0
            txtEstimatedTime.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var btnCurrentTime:UIButton!
    @IBOutlet weak var txtCurrentTime:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtCurrentTime,
                              tfName: txtCurrentTime.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Current Time")*/
            
            
            txtCurrentTime.borderStyle = .none
            txtCurrentTime.layer.masksToBounds = false
            txtCurrentTime.layer.cornerRadius = 5.0;
            txtCurrentTime.layer.backgroundColor = UIColor.white.cgColor
            txtCurrentTime.layer.borderColor = UIColor.clear.cgColor
            txtCurrentTime.layer.shadowColor = UIColor.black.cgColor
            txtCurrentTime.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtCurrentTime.layer.shadowOpacity = 0.2
            txtCurrentTime.layer.shadowRadius = 4.0
            txtCurrentTime.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var btnActualArrivalTime:UIButton!
    @IBOutlet weak var txtActualArrivalTime:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtActualArrivalTime,
                              tfName: txtActualArrivalTime.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Actual Arrival Time")*/
            
            
            txtActualArrivalTime.borderStyle = .none
            txtActualArrivalTime.layer.masksToBounds = false
            txtActualArrivalTime.layer.cornerRadius = 5.0;
            txtActualArrivalTime.layer.backgroundColor = UIColor.white.cgColor
            txtActualArrivalTime.layer.borderColor = UIColor.clear.cgColor
            txtActualArrivalTime.layer.shadowColor = UIColor.black.cgColor
            txtActualArrivalTime.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtActualArrivalTime.layer.shadowOpacity = 0.2
            txtActualArrivalTime.layer.shadowRadius = 4.0
            txtActualArrivalTime.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var btnEstimateArrivalTime:UIButton!
    @IBOutlet weak var txtEstimateArrivalTime:UITextField! {
        didSet {
            /*Utils.textFieldUI(textField: txtEstimateArrivalTime,
                              tfName: txtEstimateArrivalTime.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Estimated Arrival Time")*/
            
            
            txtEstimateArrivalTime.borderStyle = .none
            txtEstimateArrivalTime.layer.masksToBounds = false
            txtEstimateArrivalTime.layer.cornerRadius = 5.0;
            txtEstimateArrivalTime.layer.backgroundColor = UIColor.white.cgColor
            txtEstimateArrivalTime.layer.borderColor = UIColor.clear.cgColor
            txtEstimateArrivalTime.layer.shadowColor = UIColor.black.cgColor
            txtEstimateArrivalTime.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEstimateArrivalTime.layer.shadowOpacity = 0.2
            txtEstimateArrivalTime.layer.shadowRadius = 4.0
            txtEstimateArrivalTime.setLeftPaddingPoints(20)
            
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
