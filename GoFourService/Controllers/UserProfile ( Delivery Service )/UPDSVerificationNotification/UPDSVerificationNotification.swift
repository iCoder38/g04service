//
//  UPDSVerificationNotification.swift
//  GoFourService
//
//  Created by Dishant Rajput on 20/10/21.
//

import UIKit

class UPDSVerificationNotification: UIViewController {

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
                lblNavigationTitle.text = VerificationNotification_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "VerificationNotificationTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }

    @IBOutlet weak var btnTrackOrder:UIButton!{
        didSet{
            btnTrackOrder.backgroundColor = NAVIGATION_COLOR
            btnTrackOrder.setTitle("TRACK YOUR ORDER", for: .normal)
            btnTrackOrder.setTitleColor(.white, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        self.btnBack.addTarget(self, action: #selector(backClickMethod), for: .touchUpInside)
        btnTrackOrder.addTarget(self, action: #selector(btnTrackOrderPress), for: .touchUpInside)
    }
    
    @objc func backClickMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnTrackOrderPress() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSDelivery")
        self.navigationController?.pushViewController(push, animated: true)
    }


}

extension UPDSVerificationNotification:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UPDSVerificationNotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSVerificationNotificationTableViewCell
        
        //cell.backgroundColor = .lightGray
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.imgDriver.image = UIImage(named: "david")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 832
    }
    
}

extension UPDSVerificationNotification:UITableViewDelegate{
    
}
