//
//  AppDelegate.swift
//  GoFourService
//
//  Created by Apple on 31/12/20.
//

import UIKit
import Firebase
import AudioToolbox
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate , MessagingDelegate {
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
        self.fetchDeviceToken()
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    // MARK:- FIREBASE NOTIFICATION -
    @objc func fetchDeviceToken() {
        
        Messaging.messaging().token { token, error in
            if let error = error {
                
                print("Error fetching FCM registration token: \(error)")
                
            } else if let token = token {
                
                print("FCM registration token: \(token)")
                // self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
                
                let defaults = UserDefaults.standard
                defaults.set("\(token)", forKey: "key_my_device_token")

            }
        }
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error = ",error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // MARK:- WHEN APP IS OPEN -
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //print("User Info = ",notification.request.content.userInfo)
        
        print("User Info dishu = ",notification.request.content.userInfo)
        
        /*
         [AnyHashable("duration"): 18 mins, AnyHashable("RequestDropLatLong"): 13.74617,100.535124, AnyHashable("gcm.message_id"): 1658214867614998, AnyHashable("google.c.sender.id"): 667327318779, AnyHashable("total"): 28.5, AnyHashable("type"): request, AnyHashable("RequestPickupAddress"): Wat Phraya Krai Bang Kho Laem Bangkok,Bangkok,Thailand, AnyHashable("aps"): {
             alert =     {
                 body = "New booking request for Confir or Cancel.";
                 title = "New booking request for Confir or Cancel.";
             };
             sound = Default;
         }, AnyHashable("google.c.a.e"): 1, AnyHashable("distance"): 5.7, AnyHashable("RequestDropAddress"): Siam Paragon Siam Paragon, AnyHashable("bookingId"): 75, AnyHashable("RequestPickupLatLong"): 13.708315110256308,100.50983856966911, AnyHashable("google.c.fid"): d6bqrLAHbEpalOrxlMEv_D, AnyHashable("message"): New booking request for Confir or Cancel.]
         */
        
        let notification_item = notification.request.content.userInfo
        
        if (notification_item["type"] as! String) == "request" {
            
            completionHandler([/*.banner,*/.badge, .sound])
            self.request_notification_for_driver_from_customer(dictOfNotification: notification_item as NSDictionary)
            
        } else if (notification_item["type"] as! String) == "confirm" {
            
            // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "user_order_accepted_id") as? user_order_accepted
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let destinationController = storyboard.instantiateViewController(withIdentifier:"user_order_accepted_id") as? user_order_accepted
            
            destinationController?.str_get_status = "1"
            destinationController?.dict_get_accepted_booking_details = notification_item as NSDictionary
            
            let frontNavigationController = UINavigationController(rootViewController: destinationController!)
            let rearViewController = storyboard.instantiateViewController(withIdentifier:"MenuControllerVCId") as? MenuControllerVC
            let mainRevealController = SWRevealViewController()
            mainRevealController.rearViewController = rearViewController
            mainRevealController.frontViewController = frontNavigationController
        
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController = mainRevealController
            }
        
        // window?.rootViewController = mainRevealController
            window?.makeKeyAndVisible()
            
        } else if (notification_item["type"] as! String) == "arrived" {
            
            // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "user_order_accepted_id") as? user_order_accepted
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let destinationController = storyboard.instantiateViewController(withIdentifier:"user_order_accepted_id") as? user_order_accepted
            
            destinationController?.str_get_status = "2"
            destinationController?.dict_get_accepted_booking_details = notification_item as NSDictionary
            
            let frontNavigationController = UINavigationController(rootViewController: destinationController!)
            let rearViewController = storyboard.instantiateViewController(withIdentifier:"MenuControllerVCId") as? MenuControllerVC
            let mainRevealController = SWRevealViewController()
            mainRevealController.rearViewController = rearViewController
            mainRevealController.frontViewController = frontNavigationController
        
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController = mainRevealController
            }
        
        // window?.rootViewController = mainRevealController
            window?.makeKeyAndVisible()
            
        }  else if (notification_item["type"] as! String) == "ridestart" {
            
            // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "user_order_accepted_id") as? user_order_accepted
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let destinationController = storyboard.instantiateViewController(withIdentifier:"user_order_accepted_id") as? user_order_accepted
            
            destinationController?.str_get_status = "3"
            destinationController?.dict_get_accepted_booking_details = notification_item as NSDictionary
            
            let frontNavigationController = UINavigationController(rootViewController: destinationController!)
            let rearViewController = storyboard.instantiateViewController(withIdentifier:"MenuControllerVCId") as? MenuControllerVC
            let mainRevealController = SWRevealViewController()
            mainRevealController.rearViewController = rearViewController
            mainRevealController.frontViewController = frontNavigationController
        
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController = mainRevealController
            }
        
        // window?.rootViewController = mainRevealController
            window?.makeKeyAndVisible()
            
        }  else if (notification_item["type"] as! String) == "rideend" {
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let destinationController = storyboard.instantiateViewController(withIdentifier:"UPDOInvoice_id") as? UPDOInvoice
            
            // destinationController?.str_get_status = "3"
            destinationController?.get_dict_invoice = notification_item as NSDictionary
            
            let frontNavigationController = UINavigationController(rootViewController: destinationController!)
            let rearViewController = storyboard.instantiateViewController(withIdentifier:"MenuControllerVCId") as? MenuControllerVC
            let mainRevealController = SWRevealViewController()
            mainRevealController.rearViewController = rearViewController
            mainRevealController.frontViewController = frontNavigationController
        
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController = mainRevealController
            }
        
        // window?.rootViewController = mainRevealController
            window?.makeKeyAndVisible()
            
        } else if (notification_item["type"] as! String) == "PaymentDriver" || (notification_item["type"] as! String) == "PaymentUser" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let destinationController = storyboard.instantiateViewController(withIdentifier:"success_ride_status_id") as? success_ride_status
            
            // destinationController?.str_get_status = "3"
            // destinationController?.get_dict_invoice = notification_item as NSDictionary
            
            let frontNavigationController = UINavigationController(rootViewController: destinationController!)
            let rearViewController = storyboard.instantiateViewController(withIdentifier:"MenuControllerVCId") as? MenuControllerVC
            let mainRevealController = SWRevealViewController()
            mainRevealController.rearViewController = rearViewController
            mainRevealController.frontViewController = frontNavigationController
        
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController = mainRevealController
            }
        
        // window?.rootViewController = mainRevealController
            window?.makeKeyAndVisible()
            
            
        }
        
        
        
    }
    
    // MARK:- WHEN APP IS IN BACKGROUND - ( after click popup ) -
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)
        
        let background_notification_item = response.notification.request.content.userInfo
        print(background_notification_item as Any)
        
    }
    
    
    // MARK: - NOTIFICATION ( REQUEST ) -
    @objc func request_notification_for_driver_from_customer(dictOfNotification:NSDictionary) {
        print(dictOfNotification as Any)
        
        /*
         AudioServicesPlaySystemSound(1519) // Actuate "Peek" feedback (weak boom)
         AudioServicesPlaySystemSound(1520) // Actuate "Pop" feedback (strong boom)
         AudioServicesPlaySystemSound(1521) // Actuate "Nope" feedback (series of three weak booms)
         */
        
        AudioServicesPlaySystemSound(1521)
        
        var dict_1: Dictionary<AnyHashable, Any>
        var dict_2: Dictionary<AnyHashable, Any>
        
        dict_1 = dictOfNotification["aps"] as! Dictionary<AnyHashable, Any>
        dict_2 = dict_1["alert"] as! Dictionary<AnyHashable, Any>
        
        let panic_notification_title    = (dict_2["title"] as! String)
        // let panic_notification_message  = (dict_2["body"] as! String)
        
        let str_duration    = "Duration :"+(dictOfNotification["duration"] as! String)
        let str_est_price   = "\n\nEst price :$\(dictOfNotification["total"]!)"
        
        let str_pick_up_address = "\n\nPICKUP ADDRESS :\n"+(dictOfNotification["RequestPickupAddress"] as! String)
        let str_drop_address    = "\n\nDROP ADDRESS :\n"+(dictOfNotification["RequestDropAddress"] as! String)
        
        let full_message = String(str_duration)+String(str_est_price)+String(str_pick_up_address)+String(str_drop_address)
        
        let alert = NewYorkAlertController(title: panic_notification_title, message: String(full_message), style: .alert)
        
        // alert.addImage(UIImage.gif(name: "successRecharge"))
        // alert.addImage(UIImage(named: "notification_alert"))

        
        
        
        
        
        let accept_request = NewYorkButton(title: "Accept", style: .default) {
            _ in
            print("accept clicked")
            
            self.driver_accept_request_WB(dict_get_all_details: dictOfNotification)
        }
        
        let reject_Request = NewYorkButton(title: "Reject", style: .default) {
            _ in
            print("reject clicked")
        }
        
        accept_request.setDynamicColor(.green)
        accept_request.setDynamicColor(.red)
        
        alert.addButtons([accept_request,reject_Request])
        
        UIApplication.topMostViewController2?.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    // WEBSERVICES
    @objc func driver_accept_request_WB(dict_get_all_details:NSDictionary) {
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        /*let x3 : Int = (dictGetPatientDetails["medicalHistoryId"] as! Int)
         let myString2 = String(x3)*/
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
        let params = driver_accept_request(action: "driverconfirm",
                                           driverId: String(myString),
                                           bookingId: "\(dict_get_all_details["bookingId"]!)")
        
        print(params as Any)
        
        AF.request(application_base_url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
            // debugPrint(response.result)
            
            switch response.result {
            case let .success(value):
                
                let JSON = value as! NSDictionary
                print(JSON as Any)
                
                var strSuccess : String!
                strSuccess = JSON["status"]as Any as? String
                
                // var strSuccess2 : String!
                // strSuccess2 = JSON["msg"]as Any as? String
                
                if strSuccess == String("success") {
                    print("yes")
                    
                    ERProgressHud.sharedInstance.hide()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)

                    let destinationController = storyboard.instantiateViewController(withIdentifier:"driver_accept_requests_id") as? driver_accept_requests
                    
                    
                    destinationController?.str_customer_name = (JSON["UserName"] as! String)
                    destinationController?.str_customer_contact_number = (JSON["UserContactNumber"] as! String)
                    
                    // destinationController?.str_get_status = "1"
                    destinationController?.dict_get_full_data = dict_get_all_details as NSDictionary
                    
                    let frontNavigationController = UINavigationController(rootViewController: destinationController!)
                    let rearViewController = storyboard.instantiateViewController(withIdentifier:"MenuControllerVCId") as? MenuControllerVC
                    let mainRevealController = SWRevealViewController()
                    mainRevealController.rearViewController = rearViewController
                    mainRevealController.frontViewController = frontNavigationController
                
                    DispatchQueue.main.async {
                        UIApplication.shared.keyWindow?.rootViewController = mainRevealController
                    }
                
                // window?.rootViewController = mainRevealController
                    self.window?.makeKeyAndVisible()
                    
                } else {
                    
                    print("no")
                    ERProgressHud.sharedInstance.hide()
                    
                    
                }
                
            case let .failure(error):
                print(error)
                ERProgressHud.sharedInstance.hide()
                
                //Utils.please_check_your_internet_connection()
                // Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
            }
        }
        
         }
    }
    
}


extension UIApplication {
    
    /// The top most view controller
     static var topMostViewController2: UIViewController? {
         return UIApplication.shared.keyWindow?.rootViewController?.visibleViewController2
     }
    
}

extension UIViewController {
    
    /// The visible view controller from a given view controller
    var visibleViewController2: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController2
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController2
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController2
        } else {
            return self
        }
    }
    
}
