//
//  DonationCollectionCell.swift
//  GoFourService
//
//  Created by Apple on 04/03/21.
//

import UIKit

class DonationCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblDonationTitleName:UILabel! {
        didSet {
            lblDonationTitleName.layer.cornerRadius = 26
            lblDonationTitleName.clipsToBounds = true
        }
    }
}
