//
//  UPSDOrderDetailsCategoryCollectionCell.swift
//  GoFourService
//
//  Created by Apple on 04/01/21.
//

import UIKit

class UPSDOrderDetailsCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblFoodCategory:UILabel! {
        didSet {
            lblFoodCategory.textColor = .white
        }
    }
    
}
