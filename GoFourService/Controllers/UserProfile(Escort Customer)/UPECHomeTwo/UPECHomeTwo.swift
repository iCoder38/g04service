//
//  UPECHomeTwo.swift
//  GoFourService
//
//  Created by Dishant Rajput on 23/10/21.
//

import UIKit

class UPECHomeTwo: UIViewController {

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
                lblNavigationTitle.text = "HOME"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
           
    let cellReuseIdentifier = "HomeTwoTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var btnConfirmBooking:UIButton! {
        didSet {
            btnConfirmBooking.backgroundColor = NAVIGATION_COLOR
           btnConfirmBooking.addTarget(self, action: #selector(btnConfirmBookingClickMethod), for: .touchUpInside)
            btnConfirmBooking.setTitle("CONFIRM BOOKING", for: .normal)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
    }
    

    @objc func btnConfirmBookingClickMethod(){
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPECConfirmBooking") as? UPECConfirmBooking
        self.navigationController?.pushViewController(push!, animated: true)
    }
}

//MARK:- TABLE VIEW -
extension UPECHomeTwo: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPECHomeTwoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPECHomeTwoTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
}

extension UPECHomeTwo: UITableViewDelegate {
    
}
