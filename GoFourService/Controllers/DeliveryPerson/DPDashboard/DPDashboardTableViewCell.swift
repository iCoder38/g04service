//
//  DPDashboardTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 26/10/21.
//

import UIKit

class DPDashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile:UIImageView!
    
    @IBOutlet weak var cellView:UIView!{
        didSet{
            cellView.layer.cornerRadius = 124
            cellView.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblToken:UILabel!
    @IBOutlet weak var btnAdrress:UIButton!{
        didSet{
            btnAdrress.isEnabled = false
        }
    }
    @IBOutlet weak var btnDeiveryRequest:UIButton!{
        didSet{
            btnDeiveryRequest.setTitle("DELIVERY REQUEST", for: .normal)
        }
    }
    
    
    @IBOutlet weak var btn_1:UIButton!{
        didSet{
            // btnDeiveryRequest.setTitle("DELIVERY REQUEST", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_2:UIButton!{
        didSet{
            // btnDeiveryRequest.setTitle("DELIVERY REQUEST", for: .normal)
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
