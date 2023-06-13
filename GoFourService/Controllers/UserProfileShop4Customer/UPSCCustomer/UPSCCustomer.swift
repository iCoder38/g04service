//
//  UPSCCustomer.swift
//  GoFourService
//
//  Created by Dishant Rajput on 02/11/21.
//

import UIKit

class UPSCCustomer: UIViewController {
    
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
            lblNavigationTitle.text = "Shop 4 Customer"
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    let cellReuseIdentifier = "CustomerTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        print("====> here i am")
    }
    
    @objc func next_click_method() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPSCCustomerTableViewCell
        
        let custom_dict = ["what_would_you_like":String(cell.txtViewFirst.text!),
                           "store_you_live":String(cell.txtViewSecond.text!)]
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPSCCustomerTwo_id") as? UPSCCustomerTwo
        push!.get_dict_from_store_page = custom_dict as NSDictionary
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
}

//MARK:- TABLE VIEW -
extension UPSCCustomer: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPSCCustomerTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPSCCustomerTableViewCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        //cell.lbl
        
        cell.btnNext.addTarget(self, action: #selector(next_click_method), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
}

extension UPSCCustomer: UITableViewDelegate {
    
}
