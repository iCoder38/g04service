//
//  UPECBookingHistory.swift
//  GoFourService
//
//  Created by Dishant Rajput on 25/10/21.
//

import UIKit

class UPECBookingHistory: UIViewController {

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
    
    @IBOutlet weak var btnNavigationSearch:UIButton!{
        didSet{
            btnNavigationSearch.setTitle("", for: .normal)
        }
    }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "BookingHistoryTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.tableFooterView = UIView.init(frame: CGRect(origin: .zero, size: .zero))
    }


}

//MARK:- TABLE VIEW -
extension UPECBookingHistory: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPECBookingHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPECBookingHistoryTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.imgProfileImage.image = UIImage(named: "david")
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension UPECBookingHistory: UITableViewDelegate {
    
}
