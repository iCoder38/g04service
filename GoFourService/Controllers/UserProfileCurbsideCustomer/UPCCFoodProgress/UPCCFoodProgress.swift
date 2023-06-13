//
//  UPCCFoodProgress.swift
//  GoFourService
//
//  Created by Dishant Rajput on 28/10/21.
//

import UIKit

class UPCCFoodProgress: UIViewController {
    
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
                lblNavigationTitle.text = FOODVERIFICATION_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "FoodProgressTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var lblNumOfItems:UILabel!
    
    @IBOutlet weak var btnPlaceOrder:UIButton! {
        didSet {
            btnPlaceOrder.backgroundColor = .systemGreen
            //btnPlaceOrder.addTarget(self, action: #selector(placeOrderClickMethod), for: .touchUpInside)
            btnPlaceOrder.setTitle("Your Food is in the Kitchen", for: .normal)
        }
    }
    
    @IBOutlet weak var viewBg:UIView! {
        didSet {
            viewBg.layer.cornerRadius = 8
            viewBg.clipsToBounds = true
            viewBg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBg.layer.shadowOpacity = 1.0
            viewBg.layer.shadowRadius = 15.0
            viewBg.layer.masksToBounds = false
            //viewCellbg.backgroundColor = .clear
    
        }
    }
    
    @IBOutlet weak var btnStarOne:UIButton!
    @IBOutlet weak var btnStarTwo:UIButton!
    @IBOutlet weak var btnStarThree:UIButton!
    @IBOutlet weak var btnStarFour:UIButton!
    @IBOutlet weak var btnStarFive:UIButton!
    
    @IBOutlet weak var txtViewComment: UITextView!{
        didSet{
            txtViewComment.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.tbleView.separatorColor = .clear
    
    
    }
    
        
}

//MARK:- TABLE VIEW -
extension UPCCFoodProgress: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPCCFoodProgressTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPCCFoodProgressTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.lblPrice.text = "Price: " + "$150.00"
        cell.lblQuantity.text = "Qty: " + "1"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension UPCCFoodProgress: UITableViewDelegate {
    
}

extension UPCCFoodProgress:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            textView.backgroundColor = UIColor.lightGray
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            textView.backgroundColor = UIColor.white
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
}
