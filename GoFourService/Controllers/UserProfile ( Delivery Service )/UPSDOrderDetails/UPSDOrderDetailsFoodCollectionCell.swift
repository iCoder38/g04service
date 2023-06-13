//
//  UPSDOrderDetailsFoodCollectionCell.swift
//  GoFourService
//
//  Created by Apple on 04/01/21.
//

import UIKit

class UPSDOrderDetailsFoodCollectionCell: UICollectionViewCell {
    
    /*@IBOutlet weak var stepper1: ValueStepper! {
        didSet {
            stepper1.enableManualEditing = true
            stepper1.isHidden = true
            stepper1.disabledIconButtonColor = .systemGreen
            stepper1.tintColor = .systemGreen
        }
    }*/
    
    @IBOutlet weak var imgFoodProfile:UIImageView! {
        didSet {
            imgFoodProfile.backgroundColor = .clear
        }
    }
    @IBOutlet weak var imgVegNonveg:UIImageView!  {
           didSet {
               imgVegNonveg.backgroundColor = .clear
           }
       }
    
    @IBOutlet weak var lblFoodName:UILabel!
    @IBOutlet weak var lblOldPrice:UILabel!
    @IBOutlet weak var lblRealPrice:UILabel!
    
    @IBOutlet weak var viewCellBG:UIView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btnAdd:UIButton! {
        didSet {
            btnAdd.setTitleColor(.white, for: .normal)
            btnAdd.backgroundColor = NAVIGATION_COLOR
            btnAdd.layer.cornerRadius = 6
            btnAdd.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var stepper: GMStepper!
    
    @IBOutlet weak var viewPriceBG:UIView! {
        didSet {
            viewPriceBG.layer.cornerRadius = 4
            viewPriceBG.clipsToBounds = true
        }
    }
}
