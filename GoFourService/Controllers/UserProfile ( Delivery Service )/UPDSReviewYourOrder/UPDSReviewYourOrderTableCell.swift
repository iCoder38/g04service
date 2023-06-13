//
//  UPDSReviewYourOrderTableCell.swift
//  GoFourService
//
//  Created by Apple on 04/03/21.
//

import UIKit

class UPDSReviewYourOrderTableCell: UITableViewCell {

    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var imgFoodImage:UIImageView! {
        didSet {
            imgFoodImage.layer.cornerRadius = 8
            imgFoodImage.clipsToBounds = true
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
