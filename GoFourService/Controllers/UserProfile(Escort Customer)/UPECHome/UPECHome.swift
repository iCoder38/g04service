//
//  UPECHome.swift
//  GoFourService
//
//  Created by Dishant Rajput on 22/10/21.
//

import UIKit

class UPECHome: UIViewController {

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
                lblNavigationTitle.text = DASHBOARD_PAGE_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "HomeTableViewCell"
    
    @IBOutlet weak var btnContinue:UIButton! {
        didSet {
            btnContinue.backgroundColor = NAVIGATION_COLOR
        }
    }
    
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
        
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! PDCompleteAddressDetailsTableCell
        
        self.btnContinue.addTarget(self, action: #selector(continueClickMethod), for: .touchUpInside)
        
        self.sideBarMenuClick()
    }
    
    @objc func sideBarMenuClick() {
        
        self.view.endEditing(true)
        if revealViewController() != nil {
            btnBack.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            revealViewController().rearViewRevealWidth = 300
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func continueClickMethod() {
        let settingsVCId = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPECSuccessRateDriver") as? UPECSuccessRateDriver
        self.navigationController?.pushViewController(settingsVCId!, animated: true)
    }

}

//MARK:- TABLE VIEW -
extension UPECHome: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPECHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPECHomeTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        
        //cell.btnEstimatedDate.addTarget(self, action: #selector(estimateDateClickMethod), for: .touchUpInside)
        //cell.btnEstimatedTime.addTarget(self, action: #selector(estimatedTimeClickMethod), for: .touchUpInside)
        //cell.btnCurrentTime.addTarget(self, action: #selector(currentTimeClickMethod), for: .touchUpInside)
        //cell.btnActualArrivalTime.addTarget(self, action: #selector(actualArrivalTimeClickMethod), for: .touchUpInside)
        //cell.btnEstimateArrivalTime.addTarget(self, action: #selector(estimateArrivalTimeClickMethod), for: .touchUpInside)
        
        return cell
    }
    
    @objc func estimateDateClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSDashboardTwoTableCell
        
        RPicker.selectDate(title: "Select Date", minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            // self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            cell.txtEstimatedDate.text = selectedDate.dateString("dd / MMM / YYYY")
            self!.tbleView.reloadData()
        })
        
    }
    
    @objc func estimatedTimeClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSDashboardTwoTableCell
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
            // TODO: Your implementation for date
             cell.txtEstimatedTime.text = selectedDate.dateString("hh:mm a")
            self!.tbleView.reloadData()
        })
    }
    
    @objc func currentTimeClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSDashboardTwoTableCell
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
            // TODO: Your implementation for date
             cell.txtCurrentTime.text = selectedDate.dateString("hh:mm a")
            self!.tbleView.reloadData()
        })
        
    }
    
    @objc func actualArrivalTimeClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSDashboardTwoTableCell
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
            // TODO: Your implementation for date
             cell.txtActualArrivalTime.text = selectedDate.dateString("hh:mm a")
            self!.tbleView.reloadData()
        })
        
    }
    
    @objc func estimateArrivalTimeClickMethod() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDSDashboardTwoTableCell
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
            // TODO: Your implementation for date
             cell.txtEstimateArrivalTime.text = selectedDate.dateString("hh:mm a")
            self!.tbleView.reloadData()
        })
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
    
}

extension UPECHome: UITableViewDelegate {
    
}
