//
//  DPWorkingHour.swift
//  GoFourService
//
//  Created by Dishant Rajput on 27/10/21.
//

import UIKit

class DPWorkingHour: UIViewController {
    
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
                lblNavigationTitle.text = "THANK YOU"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let paddingFromLeftIs:CGFloat = 34
    
    @IBOutlet weak var btnSave:UIButton! {
        didSet {
            btnSave.backgroundColor = .black
            btnSave.layer.cornerRadius = 8.0
            btnSave.clipsToBounds = true
            //btnSave.addTarget(self, action: #selector(btnPayClickMethod), for: .touchUpInside)
            btnSave.setTitle("SAVE", for: .normal)
        }
    }
    @IBOutlet weak var lbl: UILabel!{
        didSet{
            lbl.text =
"""
Select working slot hour from
Monday to Sunday
"""
        }
    }
    
    @IBOutlet weak var btnStart:UIButton!{
        didSet{
            btnStart.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var btnEnd:UIButton!{
        didSet{
            btnEnd.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var btnStatingHour:UIButton!{
        didSet{
            btnStatingHour.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var btnEndHour:UIButton!{
        didSet{
            btnEndHour.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var txtStartingHour:UITextField!{
        didSet {
            Utils.textFieldUI(textField: txtStartingHour,
                              tfName: txtStartingHour.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "From Hour")
        }
    }
    @IBOutlet weak var txtEndHour:UITextField!{
        didSet {
            Utils.textFieldUI(textField: txtEndHour,
                              tfName: txtEndHour.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "To Hour")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
