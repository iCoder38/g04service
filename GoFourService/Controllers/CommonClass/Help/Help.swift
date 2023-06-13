//
//  Help.swift
//  GoFourService
//
//  Created by Dishant Rajput on 22/10/21.
//

import UIKit

class Help: UIViewController {
    
    @IBOutlet weak var imgView:UIImageView!
    
    @IBOutlet weak var lblWelcomeMessage:UILabel! {
        didSet {
            lblWelcomeMessage.text = "Welcome to Go4 Delivery Services."
        }
    }
    
    @IBOutlet weak var btnPhone:UIButton! {
        didSet {
            btnPhone.setTitle("901-325-2479", for: .normal)
        }
    }
    
    @IBOutlet weak var btnEmail:UIButton! {
        didSet{
            btnEmail.setTitle("go4deliveryservices@gmail.com", for: .normal)
        }
    }
    
    @IBOutlet weak var lbl:UILabel!{
        didSet{

            lbl.text = "© 2022 Go4 Delivery Services.All rights reserved"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
