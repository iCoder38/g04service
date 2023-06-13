//
//  UPDSOrderHistoryTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 22/10/21.
//

import UIKit

class UPDSOrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            viewCellbg.backgroundColor = .white
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var imgFoodImage:UIImageView! {
        didSet {
            imgFoodImage.layer.cornerRadius = 8
            imgFoodImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lblRestaurantName:UILabel!
    @IBOutlet weak var lblTotalItem:UILabel!{
        didSet{
            lblTotalItem.layer.cornerRadius = 5.0
            lblTotalItem.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblTotalAmount:UILabel!
    @IBOutlet weak var lblDateNTime:UILabel!
    
    @IBOutlet weak var lblStatus:UILabel!{
        didSet{
            lblStatus.layer.cornerRadius = 5.0
            lblStatus.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var img_gif_on_the_way:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
