//
//  UPDSAddressCollectionCell.swift
//  GoFourService
//
//  Created by Apple on 04/03/21.
//

import UIKit

class UPDSAddressCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblAddress:UILabel!
    
    @IBOutlet weak var lblCategory:UILabel! {
        didSet {
            lblCategory.textColor = .black
        }
    }
    
    @IBOutlet weak var btnCategory:UIButton! {
        didSet {
            btnCategory.tintColor = .black
        }
    }
    
}
