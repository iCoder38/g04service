//
//  DPEarning.swift
//  GoFourService
//
//  Created by Dishant Rajput on 27/10/21.
//

import UIKit

class DPEarning: UIViewController {
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = NAVIGATION_BACK_COLOR
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = ORDER_FOOD_PAGE_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
    
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "EarningTableViewCell"
    
    
    
    @IBOutlet weak var segment:UISegmentedControl!
    
    @IBOutlet weak var lblTotalEarnig:UILabel!
    @IBOutlet weak var lblTotalDelivery:UILabel!
    @IBOutlet weak var lblToGet:UILabel!
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var btnCashOut:UIButton!{
        didSet{
            btnCashOut.setTitle("CASH OUT", for: .normal)
            btnCashOut.layer.cornerRadius = 10
            btnCashOut.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tbleView.separatorColor = .clear
        
    }
    

}

//MARK:- TABLE VIEW -
extension DPEarning: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DPEarningTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DPEarningTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.preservesSuperviewLayoutMargins = false
    
        cell.imgProfileImage.image = UIImage(named: "david")
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension DPEarning: UITableViewDelegate {
    
}
