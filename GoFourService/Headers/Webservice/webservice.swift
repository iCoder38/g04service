//
//  webservice.swift
//  GoFourService
//
//  Created by Apple on 04/07/22.
//

import UIKit
import Alamofire
import SystemConfiguration

class webservice: NSObject {

    class open func callPostApi(api:String, parameters:[String:AnyObject]?, complition:@escaping (AnyObject)->Void)
    {

        if self.IsInternetAvailable() == false {
            self.showAlert(title: "Whoops :(", message: "No internet connection.")
            return
        }

        let parameters = parameters

        AF.request(api, method: .post, parameters: parameters//["jsondata":base64EncodedString]
        )
        .response { response in

            do {

                if response.error != nil{
                    print(response.error as Any, terminator: "")
                }

                if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{

                    
                     print(jsonDict as Any, terminator: "")
                    
                    if jsonDict["status"] as! String == "Success" {
                        complition(jsonDict as AnyObject)
                    } else {
                        
                        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("strSuccess2"), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        //present(alert, animated: true)
                        
                    }
                    
                    

                } else {
                    self.showAlert(title: "Whoops", message: "Something went wrong. Please, try after sometime.")
                    return
                }

            } catch _ {
                print("Exception!")
            }
      }
  }

// For check Internet Connection
class open func IsInternetAvailable () -> Bool {

    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)

    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }

    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)

}

// Display Alert
class open func showAlert(title:String,message:String){

    let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("strSuccess2"), style: .alert)
    let cancel = NewYorkButton(title: "dismiss", style: .cancel)
    alert.addButtons([cancel])
    // self.present(alert, animated: true)
}

// For Convert to JSON String
class open func toJsonString(parameters:[String:AnyObject]) -> String
{
    var jsonData: NSData?
    do {
        jsonData = try JSONSerialization.data(withJSONObject: parameters, options:JSONSerialization.WritingOptions(rawValue: 0)) as NSData?
    } catch{
        print(error.localizedDescription)
        jsonData = nil
    }

    let jsonString = NSString(data: jsonData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
    return jsonString
}

// For Convert to Base64Encoded String
class open func toBase64EncodedString(_ jsonString : String) -> String
{
    let utf8str = jsonString.data(using: .utf8)
    let base64Encoded = utf8str?.base64EncodedString(options: [])
    return base64Encoded!
}
}
