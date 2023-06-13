//
//  OrderUpdateTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/11/21.
//

import UIKit

class OrderUpdateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            /*viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false*/
            viewCellbg.backgroundColor = .clear
    
        }
    }
    
    @IBOutlet weak var imgFoodImage:UIImageView! {
        didSet {
            imgFoodImage.layer.cornerRadius = 8
            imgFoodImage.clipsToBounds = true
        }
    }

    @IBOutlet weak var lblRestaurant:UILabel!
    @IBOutlet weak var lblFood:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var btnQuantity:UIButton!{
        didSet{
            btnQuantity.setTitle("1", for: .normal)
            btnQuantity.layer.cornerRadius = 2.0
            btnQuantity.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnVegNonveg:UIButton!{
        didSet{
            btnVegNonveg.setTitle("", for: .normal)
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
