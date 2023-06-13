//
//  UPECHomeTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 22/10/21.
//

import UIKit

class UPECHomeTableViewCell: UITableViewCell {
    
    let paddingFromLeftIs:CGFloat = 10
    
    
    @IBOutlet weak var txtPickUpLocation:UITextField! {
        didSet {
            
            txtPickUpLocation.borderStyle = .none
            txtPickUpLocation.layer.masksToBounds = false
            txtPickUpLocation.layer.cornerRadius = 5.0;
            txtPickUpLocation.layer.backgroundColor = UIColor.white.cgColor
            txtPickUpLocation.layer.borderColor = UIColor.clear.cgColor
            txtPickUpLocation.layer.shadowColor = UIColor.black.cgColor
            txtPickUpLocation.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtPickUpLocation.layer.shadowOpacity = 0.2
            txtPickUpLocation.layer.shadowRadius = 4.0
            txtPickUpLocation.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btnEPickUpLocation:UIButton!
    
    @IBOutlet weak var txtPickUpDate:UITextField! {
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
            
            txtPickUpDate.borderStyle = .none
            txtPickUpDate.layer.masksToBounds = false
            txtPickUpDate.layer.cornerRadius = 5.0;
            txtPickUpDate.layer.backgroundColor = UIColor.white.cgColor
            txtPickUpDate.layer.borderColor = UIColor.clear.cgColor
            txtPickUpDate.layer.shadowColor = UIColor.black.cgColor
            txtPickUpDate.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtPickUpDate.layer.shadowOpacity = 0.2
            txtPickUpDate.layer.shadowRadius = 4.0
            txtPickUpDate.setLeftPaddingPoints(20)
            
        }
    }
    @IBOutlet weak var btnPickUpDate:UIButton!
    
    @IBOutlet weak var txtEstimatedPickUpTime:UITextField! {
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
            
            
            txtEstimatedPickUpTime.borderStyle = .none
            txtEstimatedPickUpTime.layer.masksToBounds = false
            txtEstimatedPickUpTime.layer.cornerRadius = 5.0;
            txtEstimatedPickUpTime.layer.backgroundColor = UIColor.white.cgColor
            txtEstimatedPickUpTime.layer.borderColor = UIColor.clear.cgColor
            txtEstimatedPickUpTime.layer.shadowColor = UIColor.black.cgColor
            txtEstimatedPickUpTime.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEstimatedPickUpTime.layer.shadowOpacity = 0.2
            txtEstimatedPickUpTime.layer.shadowRadius = 4.0
            txtEstimatedPickUpTime.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var btnEstimatedPickUpTime:UIButton!
    
    
    @IBOutlet weak var txtVehicleColor:UITextField!{
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
            
            
            txtVehicleColor.borderStyle = .none
            txtVehicleColor.layer.masksToBounds = false
            txtVehicleColor.layer.cornerRadius = 5.0;
            txtVehicleColor.layer.backgroundColor = UIColor.white.cgColor
            txtVehicleColor.layer.borderColor = UIColor.clear.cgColor
            txtVehicleColor.layer.shadowColor = UIColor.black.cgColor
            txtVehicleColor.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtVehicleColor.layer.shadowOpacity = 0.2
            txtVehicleColor.layer.shadowRadius = 4.0
            txtVehicleColor.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtVehicleModel:UITextField!{
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
            
            
            txtVehicleModel.borderStyle = .none
            txtVehicleModel.layer.masksToBounds = false
            txtVehicleModel.layer.cornerRadius = 5.0;
            txtVehicleModel.layer.backgroundColor = UIColor.white.cgColor
            txtVehicleModel.layer.borderColor = UIColor.clear.cgColor
            txtVehicleModel.layer.shadowColor = UIColor.black.cgColor
            txtVehicleModel.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtVehicleModel.layer.shadowOpacity = 0.2
            txtVehicleModel.layer.shadowRadius = 4.0
            txtVehicleModel.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtEscortCustomerLocation:UITextField!{
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
            
            
            txtEscortCustomerLocation.borderStyle = .none
            txtEscortCustomerLocation.layer.masksToBounds = false
            txtEscortCustomerLocation.layer.cornerRadius = 5.0;
            txtEscortCustomerLocation.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerLocation.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerLocation.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerLocation.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerLocation.layer.shadowOpacity = 0.2
            txtEscortCustomerLocation.layer.shadowRadius = 4.0
            txtEscortCustomerLocation.setLeftPaddingPoints(20)
            
        }
    }
    @IBOutlet weak var btnEscortCustomerLocation:UIButton!
    
    
    
    @IBOutlet weak var btnEscortCustomerTimeStart:UIButton!
    @IBOutlet weak var txtEscortCustomerTimeStart:UITextField! {
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
            
            
            txtEscortCustomerTimeStart.borderStyle = .none
            txtEscortCustomerTimeStart.layer.masksToBounds = false
            txtEscortCustomerTimeStart.layer.cornerRadius = 5.0;
            txtEscortCustomerTimeStart.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerTimeStart.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerTimeStart.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerTimeStart.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerTimeStart.layer.shadowOpacity = 0.2
            txtEscortCustomerTimeStart.layer.shadowRadius = 4.0
            txtEscortCustomerTimeStart.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var btnEscortCustomerTimeEnd:UIButton!
    @IBOutlet weak var txtEscortCustomerTimeEnd:UITextField! {
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
            
            
            txtEscortCustomerTimeEnd.borderStyle = .none
            txtEscortCustomerTimeEnd.layer.masksToBounds = false
            txtEscortCustomerTimeEnd.layer.cornerRadius = 5.0;
            txtEscortCustomerTimeEnd.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerTimeEnd.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerTimeEnd.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerTimeEnd.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerTimeEnd.layer.shadowOpacity = 0.2
            txtEscortCustomerTimeEnd.layer.shadowRadius = 4.0
            txtEscortCustomerTimeEnd.setLeftPaddingPoints(20)
            
        }
    }

    @IBOutlet weak var txtEscortCustomerTotalTime:UITextField! {
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
            
            
            txtEscortCustomerTotalTime.borderStyle = .none
            txtEscortCustomerTotalTime.layer.masksToBounds = false
            txtEscortCustomerTotalTime.layer.cornerRadius = 5.0;
            txtEscortCustomerTotalTime.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerTotalTime.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerTotalTime.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerTotalTime.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerTotalTime.layer.shadowOpacity = 0.2
            txtEscortCustomerTotalTime.layer.shadowRadius = 4.0
            txtEscortCustomerTotalTime.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtEscortCustomerMileageBegin:UITextField! {
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
            
            
            txtEscortCustomerMileageBegin.borderStyle = .none
            txtEscortCustomerMileageBegin.layer.masksToBounds = false
            txtEscortCustomerMileageBegin.layer.cornerRadius = 5.0;
            txtEscortCustomerMileageBegin.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerMileageBegin.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerMileageBegin.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerMileageBegin.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerMileageBegin.layer.shadowOpacity = 0.2
            txtEscortCustomerMileageBegin.layer.shadowRadius = 4.0
            txtEscortCustomerMileageBegin.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtEscortCustomerMileageEnd:UITextField! {
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
            
            
            txtEscortCustomerMileageEnd.borderStyle = .none
            txtEscortCustomerMileageEnd.layer.masksToBounds = false
            txtEscortCustomerMileageEnd.layer.cornerRadius = 5.0;
            txtEscortCustomerMileageEnd.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerMileageEnd.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerMileageEnd.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerMileageEnd.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerMileageEnd.layer.shadowOpacity = 0.2
            txtEscortCustomerMileageEnd.layer.shadowRadius = 4.0
            txtEscortCustomerMileageEnd.setLeftPaddingPoints(20)
            
        }
    }
    
    @IBOutlet weak var txtEscortCustomerTotalMileage:UITextField! {
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
            
            
            txtEscortCustomerTotalMileage.borderStyle = .none
            txtEscortCustomerTotalMileage.layer.masksToBounds = false
            txtEscortCustomerTotalMileage.layer.cornerRadius = 5.0;
            txtEscortCustomerTotalMileage.layer.backgroundColor = UIColor.white.cgColor
            txtEscortCustomerTotalMileage.layer.borderColor = UIColor.clear.cgColor
            txtEscortCustomerTotalMileage.layer.shadowColor = UIColor.black.cgColor
            txtEscortCustomerTotalMileage.layer.shadowOffset = CGSize(width: 0, height: 0)
            txtEscortCustomerTotalMileage.layer.shadowOpacity = 0.2
            txtEscortCustomerTotalMileage.layer.shadowRadius = 4.0
            txtEscortCustomerTotalMileage.setLeftPaddingPoints(20)
            
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
