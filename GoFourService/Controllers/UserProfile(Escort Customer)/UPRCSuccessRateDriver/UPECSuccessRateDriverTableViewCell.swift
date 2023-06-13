//
//  UPECSuccessRateDriverTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/10/21.
//

import UIKit

class UPECSuccessRateDriverTableViewCell: UITableViewCell {
    
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
    
    
    @IBOutlet weak var viewCellbgSecond:UIView! {
        didSet {
            viewCellbgSecond.layer.cornerRadius = 8
            viewCellbgSecond.clipsToBounds = true
            viewCellbgSecond.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbgSecond.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbgSecond.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbgSecond.layer.shadowOpacity = 1.0
            viewCellbgSecond.layer.shadowRadius = 15.0
            viewCellbgSecond.layer.masksToBounds = false
            viewCellbgSecond.backgroundColor = .white
            
        }
    }
    
    @IBOutlet weak var lblTotalHours:UILabel!
    @IBOutlet weak var lblTotalTime:UILabel!
    
    @IBOutlet weak var btnNeedHelp:UIButton!{
        didSet{
            btnNeedHelp.setTitle("Submit review", for: .normal)
            btnNeedHelp.layer.cornerRadius = 8
            btnNeedHelp.clipsToBounds = true
        }
    }
    
   
    @IBOutlet weak var viewCellbgThird:UIView! {
        didSet {
            viewCellbgThird.layer.cornerRadius = 8
            viewCellbgThird.clipsToBounds = true
            viewCellbgThird.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbgThird.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbgThird.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbgThird.layer.shadowOpacity = 1.0
            viewCellbgThird.layer.shadowRadius = 15.0
            viewCellbgThird.layer.masksToBounds = false
            viewCellbgThird.backgroundColor = .white
            
        }
    }
    
    @IBOutlet weak var imgDriver:UIImageView!{
        didSet {
            imgDriver.layer.cornerRadius = 20
            imgDriver.clipsToBounds = true
            imgDriver.layer.borderWidth = 9
            imgDriver.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var lblDriverName:UILabel!
    
    @IBOutlet weak var btn_star_one:UIButton!
    @IBOutlet weak var btn_star_two:UIButton!
    @IBOutlet weak var btn_star_three:UIButton!
    @IBOutlet weak var btn_star_four:UIButton!
    @IBOutlet weak var btn_star_five:UIButton!
    
    @IBOutlet weak var lblDriverRating:UILabel!
    
    
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
  
    @IBOutlet weak var txtViewComment:UITextView! {
        didSet {
            txtViewComment.text = ""
        }
    }
    
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
