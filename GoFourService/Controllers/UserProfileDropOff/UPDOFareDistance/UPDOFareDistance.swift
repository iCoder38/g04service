//
//  UPDOFareDistance.swift
//  GoFourService
//
//  Created by Dishant Rajput on 29/10/21.
//

import UIKit
import MapKit
import Alamofire

class UPDOFareDistance: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {
    
    var myDeviceTokenIs:String!
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let annotation = MKPointAnnotation()
    let annotation2 = MKPointAnnotation()
    
    var str_from_location:String!
    var str_to_location:String!
    
    // MARK:- MY LOCATION -
    var my_location_lat:String!
    var my_location_long:String!
    
    // MARK:- PLACE LOCATION -
    var searched_place_location_lat:String!
    var searched_place_location_long:String!
    
    var str_get_category_id:String!
    
    var str_fetch_payment_method:String!
    var str_fetch_duration:String!
    var str_fetch_distance:String!
    var str_fetch_fare_estimated:String!
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var navigationBar:UIView! {
        didSet {
            navigationBar.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var btnBack:UIButton! {
        didSet {
            btnBack.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btnBack.tintColor = NAVIGATION_BACK_COLOR
        }
    }
    
    @IBOutlet weak var lblNavigationTitle:UILabel! {
        didSet {
            lblNavigationTitle.text = "Fare distance"
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    let cellReuseIdentifier = "dFareDistanceTableViewCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btnConfirmBooking:UIButton! {
        didSet {
            btnConfirmBooking.backgroundColor = NAVIGATION_COLOR
            //btnConfirmBooking.addTarget(self, action: #selector(btnConfirmBookingClickMethod), for: .touchUpInside)
            btnConfirmBooking.setTitle("Confirm booking", for: .normal)
        }
    }
    
//    @IBOutlet weak var mapView:MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btnConfirmBooking.addTarget(self, action: #selector(validation_before_confirm_booking), for: .touchUpInside)
        
        print(self.str_get_category_id as Any)
        print(self.my_location_lat as Any)
        print(self.my_location_long as Any)
        print(self.searched_place_location_lat as Any)
        print(self.searched_place_location_long as Any)
        
        
        self.tbleView.separatorColor = .clear
        
        self.get_fare_distance_WB()
        
        self.iAmHereForLocationPermission()
        
        self.edit_profile()
    }
    
    
    @objc func iAmHereForLocationPermission() {
        // Ask for Authorisation from the User.
        self.locManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                // self.strSaveLatitude = "0"
                // self.strSaveLongitude = "0"
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                
                locManager.delegate = self
                locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locManager.startUpdatingLocation()
                
            @unknown default:
                break
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.tbleView.delegate = self
        self.tbleView.dataSource = self
        self.tbleView.reloadData()
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDOFareDistanceTableViewCell
        
        cell.lblStartingLocation.text = String(self.str_from_location)
        cell.lblEndLocation.text = String(self.str_to_location)
        
        print("**********************")
        //print("Long \(manager.location!.coordinate.longitude)")
        //print("Lati \(manager.location!.coordinate.latitude)")
        //print("Alt \(manager.location!.altitude)")
        //print("Speed \(manager.location!.speed)")
        //print("Accu \(manager.location!.horizontalAccuracy)")
        //print("**********************")
        
        //print(Double((vendorLatitute as NSString).doubleValue))
        //print(Double((vendorLongitute as NSString).doubleValue))
        
        /*
         // restaurant
         self.restaurantLatitude     = (dict["deliveryLat"] as! String)
         self.restaurantLongitude    = (dict["deliveryLong"] as! String)
         
         // driver
         self.driverLatitute     = (dict["resturentLatitude"] as! String)
         self.driverLongitude    = (dict["resturentLongitude"] as! String)
         */
        
        let restaurantLatitudeDouble    = Double(self.searched_place_location_lat)
        let restaurantLongitudeDouble   = Double(self.searched_place_location_long)
        let driverLatitudeDouble        = Double(self.my_location_lat)
        let driverLongitudeDouble       = Double(self.my_location_long)
        
        let coordinate₀ = CLLocation(latitude: restaurantLatitudeDouble!, longitude: restaurantLongitudeDouble!)
        let coordinate₁ = CLLocation(latitude: driverLatitudeDouble!, longitude: driverLongitudeDouble!)
        
        /************************************** RESTAURANT LATITUTDE AND LINGITUDE  ********************************/
        // first location
        let sourceLocation = CLLocationCoordinate2D(latitude: restaurantLatitudeDouble!, longitude: restaurantLongitudeDouble!)
        /********************************************************************************************************************/
        
        
        /************************************* DRIVER LATITUTDE AND LINGITUDE ******************************************/
        // second location
        let destinationLocation = CLLocationCoordinate2D(latitude: driverLatitudeDouble!, longitude: driverLongitudeDouble!)
        /********************************************************************************************************************/
        
        //print(sourceLocation)
        //print(destinationLocation)
        
        let sourcePin = customPin(pinTitle: "You", pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Driver", pinSubTitle: "", location: destinationLocation)
        
        /***************** REMOVE PREVIUOS ANNOTATION TO GENERATE NEW ANNOTATION *******************************************/
        cell.mapView.removeAnnotations(cell.mapView.annotations)
        /********************************************************************************************************************/
        
        cell.mapView.addAnnotation(sourcePin)
        cell.mapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            
            /***************** REMOVE PREVIUOS POLYLINE TO GENERATE NEW POLYLINE *******************************/
            let overlays = cell.mapView.overlays
            cell.mapView.removeOverlays(overlays)
            /************************************************************************************/
            
            
            /***************** GET DISTANCE BETWEEN TWO CORDINATES *******************************/
            
            let distanceInMeters = coordinate₀.distance(from: coordinate₁)
            // print(distanceInMeters as Any)
            
            // remove decimal
            let distanceFloat: Double = (distanceInMeters as Any as! Double)
            // self.lblDistance.text = (String(format: "Distance : %.0f Miles away", distanceFloat/1609.344))
            print(String(format: "Distance : %.0f Miles away", distanceFloat/1609.344))
            
            /************************************************************************************/
            
            /***************** GENERATE NEW POLYLINE *******************************/
            let route = directionResonse.routes[0]
            cell.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            cell.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            /************************************************************************************/
            
        }
        cell.mapView.delegate = self
        
        self.locManager.stopUpdatingLocation()
        
        
        // speed = distance / time
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    // MARK:- GET TOTAL DISTANCE FARE -
    @objc func get_fare_distance_WB() {
        
        // self.arr_cart_list_items.removeAllObjects()
        
        self.view.endEditing(true)

        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
         
        /*if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)*/
            
            let params = get_fare_price_params(action: "getprice",
                                               pickuplatLong: String(self.my_location_lat)+","+String(self.my_location_long),
                                               droplatLong: String(self.searched_place_location_lat)+","+String(self.searched_place_location_long),
                                               categoryId: String(self.str_get_category_id))
            
            
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
                    strSuccess = (JSON["status"]as Any as? String)?.lowercased()
                    print(strSuccess as Any)
                    if strSuccess == String("success") {
                        print("yes")
                        
                        ERProgressHud.sharedInstance.hide()
                        
                        /*
                         data =     {
                             ID = 1;
                             distance = "0.3";
                             duration = "3 mins";
                             total = "1.5";
                         };
                         */
                        
                        var dict: Dictionary<AnyHashable, Any>
                        dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                        
                        let indexPath = IndexPath.init(row: 0, section: 0)
                        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDOFareDistanceTableViewCell
                        
                        cell.lbl_distance.text = (dict["distance"] as! String)+" miles"
                        cell.lbl_duration.text = (dict["duration"] as! String)
                        
                        cell.btnFareEstimate.setTitleColor(.black, for: .normal)
                        cell.btnFareEstimate.setTitle(" Fare estimate : $\(dict["total"]!)", for: .normal)
                        
                        cell.btnPromocode.setTitleColor(.black, for: .normal)
                        
                        cell.btnSelectPaymentMethod.setTitleColor(.black, for: .normal)
                        
                        /*
                         var str_fetch_payment_method:String!
                         var str_fetch_duration:String!
                         var str_fetch_distance:String!
                         var str_fetch_fare_estimated:String!
                         */
                        
                        // self.str_fetch_payment_method = (dict["distance"] as! String)
                        self.str_fetch_duration = (dict["duration"] as! String)
                        self.str_fetch_distance = (dict["distance"] as! String)
                        self.str_fetch_fare_estimated = "\(dict["total"]!)"
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"]as Any as? String
                        
                        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String(strSuccess2), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    self.please_check_your_internet_connection()
                    
                }
            }
        // }
    }
    
    @objc func payment_method_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! UPDOFareDistanceTableViewCell
        
        let dummyList = ["Please select payment method", "Cash", "Card"]
        
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) { (selctedText, atIndex) in
            // TODO: Your implementation for selection
            cell.btnSelectPaymentMethod.setTitleColor(.black, for: .normal)
            // cell.btnSelectPaymentMethod.setTitle(" Payment method : "+String(selctedText), for: .normal)
            
            cell.lbl_payment_type.textColor = .black
            cell.lbl_payment_type.text = String(selctedText)
            
        }
        
    }
    
    @objc func validation_before_confirm_booking() {
        
        let alert = NewYorkAlertController(title: String("Alert"), message: String("Are you sure you want to confirm this booking?"), style: .alert)
        
        let yes_confirm = NewYorkButton(title: "yes, confirm", style: .default) {
            _ in

            self.confirm_booking_WB()
        }
        
        let cancel = NewYorkButton(title: "dismiss", style: .destructive) {
            _ in
        }
        
        alert.addButtons([yes_confirm,cancel])
        self.present(alert, animated: true)
        
    }
    
    // MARK:- GET TOTAL DISTANCE FARE -
    @objc func confirm_booking_WB() {
        
        // self.arr_cart_list_items.removeAllObjects()
        
        
        
        self.view.endEditing(true)

        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "success_invitation_id") as? success_invitation
        
        let custom_dict = [
                           "categoryId":String(self.str_get_category_id),
                           "RequestPickupAddress":String(self.str_from_location),
                           "RequestPickupLatLong":String(self.my_location_lat)+","+String(self.my_location_long),
                           "RequestDropAddress":String(self.str_to_location),
                           "RequestDropLatLong":String(self.searched_place_location_lat)+","+String(self.searched_place_location_long),
                           "duration":String(self.str_fetch_duration),
                           "distance":String(self.str_fetch_distance),
                           "total":String(self.str_fetch_fare_estimated)
        ]
        
        push!.dict_get_all_add_booking_data = custom_dict as NSDictionary
        
        self.navigationController?.pushViewController(push!, animated: true)
        
        
    }
    
    
    @objc func edit_profile() {
        print("edit profile call")
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if Login.IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        // 13.708233729327171 100.51003435701973
        
        
        // key_my_device_token
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
        let defaults = UserDefaults.standard
        if let myString = defaults.string(forKey: "key_my_device_token") {
            self.myDeviceTokenIs = myString
            
        }
        else {
            self.myDeviceTokenIs = "111111111111111111111"
        }
        
        let parameters = [
            "action"        : "editprofile",
            "userId"        : String(myString),
            "latitude"      : String(self.my_location_lat),
            "longitude"     : String(self.my_location_long),
            "deviceToken"   : String(myDeviceTokenIs)
            // "deviceToken"   : "",
        ]
        
        AF.request(application_base_url, method: .post, parameters: parameters)
        
        .response { response in
            
            do {
                if response.error != nil{
                    print(response.error as Any, terminator: "")
                }
                
                if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{
                    
                    print(jsonDict as Any, terminator: "")

                    // for status alert
                    var status_alert : String!
                    status_alert = (jsonDict["status"] as? String)
                    
                    // for message alert
                    var str_data_message : String!
                    str_data_message = jsonDict["msg"] as? String
                    
                    if status_alert.lowercased() == "success" {
                        
                        print("=====> yes")
                        ERProgressHud.sharedInstance.hide()
                        
                        var dict: Dictionary<AnyHashable, Any>
                        dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(dict, forKey: str_save_login_user_data)
                        
                        
                    } else {
                        
                        print("=====> no")
                        ERProgressHud.sharedInstance.hide()
                        
                        let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
                        
                    }
                    
                } else {
                    
                    self.please_check_your_internet_connection()
                    
                    return
                }
                
            } catch _ {
                print("Exception!")
            }
        }}
    }
}

//MARK:- TABLE VIEW -
extension UPDOFareDistance: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDOFareDistanceTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDOFareDistanceTableViewCell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        //cell.lbl
        
        cell.btnSelectPaymentMethod.addTarget(self, action: #selector(payment_method_click_method), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
}

extension UPDOFareDistance: UITableViewDelegate {
    
}
