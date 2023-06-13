//
//  RBOrderListTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 24/11/21.
//

import UIKit

class RBOrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAmount:UILabel!
    @IBOutlet weak var imgProfile:UIImageView!{
        didSet {
            imgProfile.layer.cornerRadius = 30
            imgProfile.clipsToBounds = true
            imgProfile.layer.borderWidth = 9
            imgProfile.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var lblFood:UILabel!
    @IBOutlet weak var lblTime:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
