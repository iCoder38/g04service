//
//  UPDSAddress.swift
//  GoFourService
//
//  Created by Apple on 04/03/21.
//

import UIKit

class UPDSAddress: UIViewController, UITextFieldDelegate {

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
                lblNavigationTitle.text = DELIVERY_ADDRESS_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "UPDSAddressTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btnPlaceOrder:UIButton! {
        didSet {
            btnPlaceOrder.backgroundColor = .black
            btnPlaceOrder.addTarget(self, action: #selector(successClickMethod), for: .touchUpInside)
            btnPlaceOrder.setTitle("SAVE & CONTINUE", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(backClickMethod), for: .touchUpInside)
        self.btnPlaceOrder.addTarget(self, action: #selector(successClickMethod), for: .touchUpInside)
        
        self.tbleView.separatorColor = .black
        
        self.view.backgroundColor = UIColor.init(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        
        self.tbleView.delegate = self
        self.tbleView.dataSource = self
        self.tbleView.reloadData()
        
        // let index = IndexPath(row: 0, section: 0)
        // self.tbleView.scrollToRow(at: index, at: .bottom, animated: true)
    }
    
    @objc func backClickMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- CONFIRM AND PAY -
    @objc func successClickMethod() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessId")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}


//MARK:- TABLE VIEW -
extension UPDSAddress: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

         if let cell = cell as? UPDSAddressTableCell {

            if indexPath.row == 0 {
                
                cell.clView.dataSource = self
                cell.clView.delegate = self
                cell.clView.tag = indexPath.section
                cell.clView.reloadData()
                
            } else {
                
            }
            

         }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! UPDSAddressTableCell
            
            cell.backgroundColor = .clear
          
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.clView.isHidden = false
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo") as! UPDSAddressTableCell
            
            cell.backgroundColor = .clear
          
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
           
            cell.txtName.delegate = self
            cell.txtAddress.delegate = self
            cell.txtCity.delegate = self
            cell.txtState.delegate = self
            cell.txtZipcode.delegate = self
            cell.txtPhone.delegate = self
            cell.txtLandmark.delegate = self
            
            return cell
            
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 162
        } else {
            return 1000
        }
        
    }
    
}

extension UPDSAddress: UITableViewDelegate {
    
    /*func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? UPDSAddressTableCell {
            // cachedPosition[indexPath] = cell.collectionView.contentOffset
            print(cell.clView.tag as Any)
        }
    }*/
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // let item = self.arrListOfAllMyOrders[section] as? [String:Any]
        // print(item as Any)
        
        // if section == 0
        
        let headerView = UIView.init(frame: CGRect.init(x: 60, y: 0, width: tableView.frame.width, height: 20))

        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        
         if section == 0 {
            label.text = "  "+"Saved Address : "
         } else if section == 1 {
             label.text = "  "+"Add New Address :"//(item!["fullName"] as! String)
         } else {
            label.text = "  "+"Check These Out:"
         }
        
        label.backgroundColor = .white
        label.layer.cornerRadius = 0
        label.clipsToBounds = true
        label.font = UIFont.init(name: "Avenir Next Bold", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        
        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 26
    }*/
    
}


//MARK:- COLLECTION VIEW -
extension UPDSAddress: UICollectionViewDelegate {
    //Write Delegate Code Here
    
}

extension UPDSAddress: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uPDSAddressCollectionCell", for: indexPath as IndexPath) as! UPDSAddressCollectionCell
            
        cell.layer.cornerRadius = 16
        cell.clipsToBounds = true
        cell.backgroundColor = .white
        
        cell.lblAddress.text = "Flat:102, Plot:39, Sector:10, Pacific Apartment, New Delhi, 110075"
        cell.lblCategory.text = "Home"
        
        return cell
        
    }
   
    //Write DataSource Code Here
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension UPDSAddress: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // if collectionView == clView {
            
         var sizes: CGSize
        // let result = UIScreen.main.bounds.size
         
        // if result.height == 480 {
                //Load 3.5 inch xib
        sizes = CGSize(width: 180.0, height: 120.0)
        /*}
        else if result.height == 568 {
                //Load 4 inch xib
            sizes = CGSize(width: 100.0, height: 80.0)
        }
        else if result.height == 667.000000 {
                //Load 4.7 inch xib , 8
            sizes = CGSize(width: 180.0, height: 216.0) // done
        }
        else if result.height == 736.000000 {
                // iphone 6s Plus and 7 Plus
            sizes = CGSize(width: 180.0, height: 216.0) // done
        }
        else if result.height == 812.000000 {
                // iphone X , 11 pro
            sizes = CGSize(width: 160.0, height: 216.0) // done
        }
        else if result.height == 896.000000 {
                // iphone Xr ,11, 11 pro max
            sizes = CGSize(width: 180.0, height: 216.0) // done
        }
        else {
            sizes = CGSize(width: 114.0, height: 216.0)
        }*/
            
        
         return sizes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
