//
//  UPDOHomeCollectionViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 29/10/21.
//

import UIKit

class UPDOHomeCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    
    @IBOutlet weak var imgCarType:UIImageView! {
        didSet {
            imgCarType.layer.cornerRadius = 25
            imgCarType.clipsToBounds = true
            imgCarType.layer.borderWidth = 5
            imgCarType.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var lblCarType:UILabel!
    @IBOutlet weak var lblExtimatedTime:UILabel!
    
    
    
}
