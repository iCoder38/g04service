//
//  UPDSOrderFoodTableCell.swift
//  GoFourService
//
//  Created by Apple on 04/01/21.
//

import UIKit

class UPDSOrderFoodTableCell: UITableViewCell {

    @IBOutlet weak var viewBG:UIView! {
        didSet {
            viewBG.layer.cornerRadius = 12
            viewBG.clipsToBounds = true
            viewBG.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var imgFoodProfileImage:UIImageView! {
        didSet {
            imgFoodProfileImage.layer.cornerRadius = 12
            imgFoodProfileImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lblFoodName:UILabel! {
        didSet {
            lblFoodName.text = "Dal Makhani"
        }
    }
    
    @IBOutlet weak var imgFoodCategory:UIImageView!
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var lblFoodCategory:UILabel! {
        didSet {
            lblFoodCategory.text = "Indian, Italian and South"
        }
    }
    
    @IBOutlet weak var lblMenu:UILabel! {
        didSet {
            lblMenu.text = " MENU "
            lblMenu.textColor = .white
            lblMenu.layer.cornerRadius = 4
            lblMenu.clipsToBounds = true
            lblMenu.backgroundColor = .systemGreen
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
