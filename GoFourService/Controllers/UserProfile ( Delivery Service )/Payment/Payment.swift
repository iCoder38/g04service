//
//  Payment.swift
//  GoFourService
//
//  Created by Dishant Rajput on 11/10/21.
//

import UIKit

class Payment: UIViewController,UITextFieldDelegate {
    
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
                lblNavigationTitle.text = PAYMENT_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    @IBOutlet weak var viewCard:UIView! {
        didSet {
            viewCard.backgroundColor = .black
            viewCard.layer.cornerRadius = 5.0
            viewCard.clipsToBounds = true
        }
    }
    
    var cardNumberCursorPreviousPosition = 0
    
    var strCardType:String!
    let cellReuseIdentifier = "paymentTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }

    @IBOutlet weak var lblCardHolderName:UILabel!{
        didSet{
            lblCardHolderName.isHidden = true
        }
    }
    @IBOutlet weak var lblCardNumberHeading:UILabel!{
        didSet{
            lblCardNumberHeading.isHidden = true
        }
    }
    @IBOutlet weak var lblEXPDate:UILabel!{
        didSet{
            lblEXPDate.isHidden = true
        }
    }
    
    @IBOutlet weak var lblPayableAmount:UILabel!
    
    @IBOutlet weak var btnmakePayment:UIButton! {
        didSet {
            btnmakePayment.backgroundColor = NAVIGATION_COLOR
            btnmakePayment.setTitle("MAKE PAYMENT", for: .normal)
            btnmakePayment.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var imgCardImage:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.strCardType = "none"
    
        self.btnmakePayment.addTarget(self, action: #selector(checkValidation), for: .touchUpInside)
        
        
        
    }
    

    @objc func checkValidation(){
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! PaymentTableViewCell
        if cell.txtCardNumber.text == "" {
            let alert = UIAlertController(title: "Card Number", message: "card number should not be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else
        if cell.txtNameOnCard.text == "" {
            let alert = UIAlertController(title: "Name", message: "Name should not be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else if cell.txtExpDate.text == "" {
            let alert = UIAlertController(title: "Exp Month", message: "Expiry Month should not be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else if cell.txtCVV.text == "" {
            let alert = UIAlertController(title: "Security Code", message: "Security Code should not be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tbleView.cellForRow(at: indexPath) as! PaymentTableViewCell
            lblEXPDate.isHidden = false
            lblEXPDate.text = cell.txtExpDate.text
            lblCardHolderName.isHidden=false
            lblCardHolderName.text = cell.txtNameOnCard.text
            lblCardNumberHeading.isHidden = false
            lblCardNumberHeading.text = cell.txtCardNumber.text
           // imgCardImage.image = UIImage(named: String(strCardType))
            
        }
    }
    
    
    
}
extension Payment:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PaymentTableViewCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txtCardNumber.delegate = self
        cell.txtExpDate.delegate = self
        cell.txtCVV.delegate = self
        //cell.txtNameOnCard.delegate = self
        
        cell.txtCardNumber.addTarget(self, action: #selector(Payment.textFieldDidChange(_:)), for: .editingChanged)
        cell.txtExpDate.addTarget(self, action: #selector(Payment.textFieldDidChange2(_:)), for: .editingChanged)
        
        return cell
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! PaymentTableViewCell
        
         self.lblCardNumberHeading.text! = cell.txtCardNumber.text!
        
    }
    @objc func textFieldDidChange2(_ textField: UITextField) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! PaymentTableViewCell
            
         self.lblEXPDate.text! = cell.txtExpDate.text!
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! PaymentTableViewCell
        
        if textField == cell.txtCardNumber {
            
            let first2 = String(cell.txtCardNumber.text!.prefix(2))
            
            if first2.count == 2 {
               // print("yes")
                
                let first3 = String(cell.txtCardNumber.text!.prefix(2))
               // print(first3 as Any)
                
                if first3 == "34" { // amex
                    self.imgCardImage.image = UIImage(named: "Amex")
                    self.strCardType = "amex"
                } else if first3 == "37" { // amex
                    self.imgCardImage.image = UIImage(named: "Amex")
                    self.strCardType = "amex"
                } else if first3 == "51" { // master
                    self.imgCardImage.image = UIImage(named: "Mastercard")
                    self.strCardType = "master"
                } else if first3 == "55" { // master
                    self.imgCardImage.image = UIImage(named: "Mastercard")
                    self.strCardType = "master"
                }  else if first3 == "42" { // visa
                    self.imgCardImage.image = UIImage(named: "visa")
                    self.strCardType = "visa"
                } else if first3 == "65" { // discover
                    self.imgCardImage.image = UIImage(named: "Discover")
                    self.strCardType = "discover"
                } else {
                    self.imgCardImage.image = UIImage(named: "ccCard")
                    self.strCardType = "none"
                }
                
            } else {
                // print("no")
                self.imgCardImage.image = UIImage(named: "ccCard")
            }
            
            
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            
            if self.strCardType == "amex" {
                return count <= 15
            } else {
                return count <= 16
            }
            
            
        }
        
        if textField == cell.txtExpDate {
            if string == "" {
                return true
            }

            
            let currentText = textField.text! as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: string)

            textField.text = updatedText
            let numberOfCharacters = updatedText.count
            
            if numberOfCharacters == 2 {
                textField.text?.append("/")
            }
            
            self.lblEXPDate.text! = cell.txtExpDate.text!
        }
        
       if textField == cell.txtCVV {
           
           guard let textFieldText = textField.text,
               let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                   return false
           }
           let substringToReplace = textFieldText[rangeOfTextToReplace]
           let count = textFieldText.count - substringToReplace.count + string.count
           return count <= 3
       }
        
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    
}
