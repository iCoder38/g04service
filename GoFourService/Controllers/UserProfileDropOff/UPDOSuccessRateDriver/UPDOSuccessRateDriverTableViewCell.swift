//
//  UPDOSuccessRateDriverTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 30/10/21.
//

import UIKit

class UPDOSuccessRateDriverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCellbgFirst:UIView! {
        didSet {
            viewCellbgFirst.layer.cornerRadius = 8
            viewCellbgFirst.clipsToBounds = true
            viewCellbgFirst.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbgFirst.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbgFirst.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbgFirst.layer.shadowOpacity = 1.0
            viewCellbgFirst.layer.shadowRadius = 15.0
            viewCellbgFirst.layer.masksToBounds = false
            viewCellbgFirst.backgroundColor = .white
            
    
        }
    }
    
    @IBOutlet weak var btnStarting:UIButton!{
        didSet{
            btnStarting.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var btnEnding:UIButton!{
        didSet{
            btnEnding.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var lblStartingLocation:UILabel!
    @IBOutlet weak var lblEndLocation:UILabel!
    

    @IBOutlet weak var btnNeedHelp:UIButton!{
        didSet{
            btnNeedHelp.setTitle("Need Help?", for: .normal)
            btnNeedHelp.layer.cornerRadius = 8
            btnNeedHelp.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnRateDriver:UIButton!{
        didSet{
            btnRateDriver.setTitle("Rate Your Driver?", for: .normal)
            btnRateDriver.layer.cornerRadius = 8
            btnRateDriver.clipsToBounds = true
        }
    }
   
    @IBOutlet weak var viewCellbgFourth:UIView! {
        didSet {
            viewCellbgFourth.layer.cornerRadius = 8
            viewCellbgFourth.clipsToBounds = true
            viewCellbgFourth.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbgFourth.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbgFourth.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbgFourth.layer.shadowOpacity = 1.0
            viewCellbgFourth.layer.shadowRadius = 15.0
            viewCellbgFourth.layer.masksToBounds = false
            viewCellbgFourth.backgroundColor = .white
            
        }
    }
  
    @IBOutlet weak var txtViewComment:UITextView!
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
