//
//  UPDOHome.swift
//  GoFourService
//
//  Created by Dishant Rajput on 29/10/21.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SDWebImage

// MARK:- LOCATION -
import CoreLocation

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class UPDOHome: UIViewController , UITextFieldDelegate, CLLocationManagerDelegate , MKMapViewDelegate {
    
    var arr_mut_list_of_category:NSMutableArray! = []
    
    let locationManager = CLLocationManager()
    
    // MARK:- SAVE LOCATION STRING -
    var strSaveLatitude:String!
    var strSaveLongitude:String!
    var strSaveCountryName:String!
    var strSaveLocalAddress:String!
    var strSaveLocality:String!
    var strSaveLocalAddressMini:String!
    var strSaveStateName:String!
    var strSaveZipcodeName:String!
    
    // apple maps
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var countryName:String!
    var stateAndCountry:String!
    var fullAddress:String!
    
    var searchLat:String!
    var searchLong:String!
    
    var str_category_id:String! = "0"
    
    var ar : NSArray!
    
    @IBOutlet weak var searchResultsTableView: UITableView! {
        didSet {
            searchResultsTableView.delegate = self
            searchResultsTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var mapView:MKMapView!
    
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
            lblNavigationTitle.text = ORDER_FOOD_PAGE_NAVIGATION_TITLE
            lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
            lblNavigationTitle.backgroundColor = .clear
        }
    }
    
    // ***************************************************************** // nav
    
    @IBOutlet weak var collectionView:UICollectionView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var map:MKMapView!
    
    @IBOutlet weak var txt_location_from:UITextField! {
        didSet {
            txt_location_from.delegate = self
            /*txt_location_from.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_location_from.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_location_from.layer.shadowOpacity = 1.0
            txt_location_from.layer.shadowRadius = 15.0
            txt_location_from.layer.masksToBounds = false
            txt_location_from.layer.cornerRadius = 15
            txt_location_from.backgroundColor = .white*/
        }
    }
    
    @IBOutlet weak var txt_location_to:UITextField! {
        didSet {
            txt_location_to.delegate = self
            /*txt_location_to.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_location_to.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_location_to.layer.shadowOpacity = 1.0
            txt_location_to.layer.shadowRadius = 15.0
            txt_location_to.layer.masksToBounds = false
            txt_location_to.layer.cornerRadius = 15
            txt_location_to.backgroundColor = .white*/
        }
    }
    
    @IBOutlet weak var viewCellbg:UIView! {
        didSet {
            viewCellbg.layer.cornerRadius = 8
            viewCellbg.clipsToBounds = true
            viewCellbg.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
            
            viewCellbg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewCellbg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewCellbg.layer.shadowOpacity = 1.0
            viewCellbg.layer.shadowRadius = 15.0
            viewCellbg.layer.masksToBounds = false
            viewCellbg.backgroundColor = .white
            
            
        }
    }
    
    @IBOutlet weak var btnStarting:UIButton!{
        didSet{
            btnStarting.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var btnEnding:UIButton!{
        didSet{
            btnEnding.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var btnRideNow:UIButton!{
        didSet{
            btnRideNow.setTitle("RIDE NOW", for: .normal)
            btnRideNow.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var btnRideLater:UIButton! {
        didSet{
            btnRideLater.setTitle("RIDE LATER", for: .normal)
            btnRideLater.backgroundColor = NAVIGATION_COLOR
        }
    }
    
    @IBOutlet weak var btn_get_current_location:UIButton! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnBack.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btnRideNow.setTitle("Ride now", for: .normal)
        self.btnRideNow.addTarget(self, action: #selector(ride_now_click_method), for: .touchUpInside)
        
        self.btn_get_current_location.addTarget(self, action: #selector(current_location_click_method), for: .touchUpInside)
        
        // apple maps
        self.mapView.delegate = self
        self.searchCompleter.delegate = self
        self.searchResultsTableView.isHidden = true
        
        self.stateAndCountry = "0"
        self.fullAddress = "0"
        
        self.searchLat = "0"
        self.searchLong = "0"
        
        self.iAmHereForLocationPermission()
        self.list_of_all_category_WB()
    }
    
    @objc func current_location_click_method() {
        
         self.iAmHereForLocationPermission()
    }
    
    @objc func iAmHereForLocationPermission() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
              
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                self.strSaveLatitude = "0"
                self.strSaveLongitude = "0"
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                          
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                      
            @unknown default:
                break
            }
        }
    }
    
    // MARK:- GET CUSTOMER LOCATION -
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! PDBagPurchaseTableCell
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.fetchCityAndCountry { city, country, zipcode,localAddress,localAddressMini,locality, error in
            guard let city = city, let country = country,let zipcode = zipcode,let localAddress = localAddress,let localAddressMini = localAddressMini,let locality = locality, error == nil else { return }
            
            self.strSaveCountryName     = country
            self.strSaveStateName       = city
            self.strSaveZipcodeName     = zipcode
            
            self.strSaveLocalAddress     = localAddress
            self.strSaveLocality         = locality
            self.strSaveLocalAddressMini = localAddressMini
            
            
            
            let doubleLat = locValue.latitude
            let doubleStringLat = String(doubleLat)
            
            let doubleLong = locValue.longitude
            let doubleStringLong = String(doubleLong)
            
            self.strSaveLatitude = String(doubleStringLat)
            self.strSaveLongitude = String(doubleStringLong)
            
            print("local address ==> "+localAddress as Any) // south west delhi
            print("local address mini ==> "+localAddressMini as Any) // new delhi
            print("locality ==> "+locality as Any) // sector 10 dwarka
            
            print(self.strSaveCountryName as Any) // india
            print(self.strSaveStateName as Any) // new delhi
            print(self.strSaveZipcodeName as Any) // 110075
            
            /*
             self.strSaveCountryName     = country
             self.strSaveStateName       = city
             */
            
            self.txt_location_from.text = String(self.strSaveLocality)+" "+String(self.strSaveLocalAddress)+" "+String(self.strSaveLocalAddressMini)+","+String(self.strSaveStateName)+","+String(self.strSaveCountryName)
            
            //MARK:- STOP LOCATION -
            self.locationManager.stopUpdatingLocation()

        }
        
    }*/
    
    @objc func ride_now_click_method() {
        
        if self.str_category_id == "0" {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please select atleast one vehicle"), style: .alert)
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            alert.addButtons([cancel])
            present(alert, animated: true)
            
        } else {
        
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDOFareDistanceId") as? UPDOFareDistance

            /*
             var my_location_lat:String!
             var my_location_long:String!
             
             // MARK:- PLACE LOCATION -
             var searched_place_location_lat:String!
             var searched_place_location_long:String!
             
             self.searchLat = String(coordinate!.latitude)
             self.searchLong
             
             var str_from_location:String!
             var str_to_location:String!
             self.stateAndCountry = String(completion.title)
             self.fullAddress = String(completion.subtitle)
             str_get_category_id
             */
            
            push!.str_get_category_id = String(self.str_category_id)
            push!.str_from_location = String(self.txt_location_from.text!)
            push!.str_to_location = String(self.stateAndCountry)+" "+String(self.stateAndCountry)
            
            push!.my_location_lat = String(self.strSaveLatitude)
            push!.my_location_long = String(self.strSaveLongitude)
            
            push!.searched_place_location_lat = String(self.searchLat)
            push!.searched_place_location_long = String(self.searchLong)
            
            self.navigationController?.pushViewController(push!, animated: true)
            
        }
        
        
    }
    
    @objc func list_of_all_category_WB() {
        
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        let params = car_list_category_params(action: "category")
        
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
                    
                    
                    self.ar = (JSON["data"] as! Array<Any>) as NSArray
                    
                    for indexx in 0..<self.ar.count {
                        
                        let item = self.ar[indexx] as? [String:Any]
                        
                        let custom_dict = ["id":"\(item!["id"]!)",
                                           "name":(item!["name"] as! String),
                                           "image":(item!["image"] as! String),
                                           "status":"no"]
                        
                        self.arr_mut_list_of_category.add(custom_dict)
                        
                    }
                    
                    // self.arr_mut_list_of_category.addObjects(from: ar as! [Any])
                    
                    self.collectionView.dataSource = self
                    self.collectionView.delegate = self
                    self.collectionView.reloadData()
                    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    // apple maps
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tbleView.cellForRow(at: indexPath) as! PDBagPurchaseTableCell
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.fetchCityAndCountry { city, country, zipcode,localAddress,localAddressMini,locality, error in
            guard let city = city, let country = country,let zipcode = zipcode,let localAddress = localAddress,let localAddressMini = localAddressMini,let locality = locality, error == nil else { return }
            
            self.strSaveCountryName     = country
            self.strSaveStateName       = city
            self.strSaveZipcodeName     = zipcode
            
            self.strSaveLocalAddress     = localAddress
            self.strSaveLocality         = locality
            self.strSaveLocalAddressMini = localAddressMini

            let doubleLat = locValue.latitude
            let doubleStringLat = String(doubleLat)
            
            let doubleLong = locValue.longitude
            let doubleStringLong = String(doubleLong)
            
            self.strSaveLatitude = String(doubleStringLat)
            self.strSaveLongitude = String(doubleStringLong)
            
            print("local address ==> "+localAddress as Any) // south west delhi
            print("local address mini ==> "+localAddressMini as Any) // new delhi
            print("locality ==> "+locality as Any) // sector 10 dwarka
            
            print(self.strSaveCountryName as Any) // india
            print(self.strSaveStateName as Any) // new delhi
            print(self.strSaveZipcodeName as Any) // 110075
            
            /*
             self.strSaveCountryName     = country
             self.strSaveStateName       = city
             */
            
            self.txt_location_from.text = String(self.strSaveLocality)+" "+String(self.strSaveLocalAddress)+" "+String(self.strSaveLocalAddressMini)+","+String(self.strSaveStateName)+","+String(self.strSaveCountryName)
            
            
            print(manager.location?.coordinate.latitude as Any)
            print(manager.location?.coordinate.longitude as Any)
            
            let sourceLocation = CLLocationCoordinate2D(latitude: Double((manager.location?.coordinate.latitude)!), longitude: Double((manager.location?.coordinate.longitude)!))
            
            let sourcePin = customPin(pinTitle: "You", pinSubTitle: "", location: sourceLocation)
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.mapView.addAnnotation(sourcePin)
            
            //MARK:- STOP LOCATION -
            self.locationManager.stopUpdatingLocation()

        }
        
    }
    
    @nonobjc func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            // annotationView?.removeFromSuperview()
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    @nonobjc func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        self.mapView.setRegion(region, animated: true)
    }
    
    
}


//MARK:- COLLECTION VIEW -
extension UPDOHome: UICollectionViewDelegate {
    //Write Delegate Code Here
    
}

extension UPDOHome: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arr_mut_list_of_category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath as IndexPath) as! UPDOHomeCollectionViewCell
        
        let item = self.arr_mut_list_of_category[indexPath.row] as? [String:Any]

        // cell.imgCarType.image = UIImage(named: "foodPlaceholder")
        cell.lblCarType.text = (item!["name"] as! String)
        // cell.lblExtimatedTime.text = (item!["name"] as! String)
        // cell.lblExtimatedTime.isHidden = true
        
        cell.imgCarType.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.imgCarType.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        if (item!["status"] as! String) == "no" {
            
            cell.imgCarType.layer.cornerRadius = 25
            cell.imgCarType.clipsToBounds = true
            cell.imgCarType.layer.borderWidth = 5
            cell.imgCarType.layer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            
        } else {
            
            cell.imgCarType.layer.cornerRadius = 25
            cell.imgCarType.clipsToBounds = true
            cell.imgCarType.layer.borderWidth = 5
            cell.imgCarType.layer.borderColor = UIColor.orange.cgColor
            
        }
        
        cell.backgroundColor  = .clear
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.arr_mut_list_of_category.removeAllObjects()
        
        for indexx in 0..<self.ar.count {
            
            let item = self.ar[indexx] as? [String:Any]
            
            let custom_dict = ["id":"\(item!["id"]!)",
                               "name":(item!["name"] as! String),
                               "image":(item!["image"] as! String),
                               "status":"no"]
            
            self.arr_mut_list_of_category.add(custom_dict)
            
        }
        
        
        let item = self.arr_mut_list_of_category[indexPath.row] as? [String:Any]
        self.str_category_id = (item!["id"] as! String)
        
        self.arr_mut_list_of_category.removeObject(at: indexPath.row)
        
        let custom_dict = ["id":(item!["id"] as! String),
                           "name":(item!["name"] as! String),
                           "image":(item!["image"] as! String),
                           "status":"yes"]
        
        self.arr_mut_list_of_category.insert(custom_dict, at: indexPath.row)
        
        print(self.str_category_id as Any)
        
        // self.str_category_id = "\(item!["id"]!)"
        
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var sizes: CGSize
        let result = UIScreen.main.bounds.size
        NSLog("%f",result.height)
        sizes = CGSize(width: 120, height: 120)
        /*if result.height == 844 {
         
         print("i am iPhone 12")
         sizes = CGSize(width: 116, height: 130)
         } else if result.height == 812 {
         
         print("i am iPhone 12 mini")
         sizes = CGSize(width: 110, height: 130)
         } else {
         
         sizes = CGSize(width: 120, height: 130)
         }*/
        
        return sizes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
        /*let result = UIScreen.main.bounds.size
         if result.height == 667.000000 { // 8
         return 2
         } else if result.height == 812.000000 { // 11 pro
         return 4
         } else {
         return 10
         }*/
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    
}


extension UPDOHome: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
        
        self.searchResultsTableView.isHidden = false
    }
}

extension UPDOHome: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension UPDOHome: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.view.endEditing(true)
        
        self.searchResultsTableView.isHidden = true
        // mapView.removeOverlay(T##overlay: MKOverlay##MKOverlay)
        
        // let overlays = self.mapView.overlays
        // self.mapView.removeOverlays(overlays)
        
        // self.mapView.removeAnnotation:self.mapView.annotations.lastObject
        
        if self.mapView.annotations.isEmpty != true {
            self.mapView.removeAnnotation(self.mapView.annotations.last!)
        }
        
        
        
        let completion = searchResults[indexPath.row]
        
        print(completion.title as Any)
        print(completion.subtitle as Any)
        
        UserDefaults.standard.synchronize()
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { [self] (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            // print(String(describing: coordinate?.latitude))
            // print(String(describing: coordinate?.longitude))
            
            print(Double(coordinate!.latitude))
            print(Double(coordinate!.longitude))
            
            // let fullAddress = completion.title+" "+completion.subtitle
            
            self.stateAndCountry = String(completion.title)
            self.fullAddress = String(completion.subtitle)
            
            self.searchLat = String(coordinate!.latitude)
            self.searchLong = String(coordinate!.longitude)
            
            /*UserDefaults.standard.set(completion.title, forKey: "keySaveLocation")
            UserDefaults.standard.set(fullAddress, forKey: "keySaveFullAddress")
            UserDefaults.standard.set(Double(coordinate!.latitude), forKey: "keySaveLatitude")
            UserDefaults.standard.set(Double(coordinate!.longitude), forKey: "keySaveLongitude")*/
            
            let london = MKPointAnnotation()
            london.title = completion.title
            london.subtitle = completion.subtitle
            mapView.delegate = self
            london.coordinate = CLLocationCoordinate2D(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
            mapView.removeAnnotation(london)
            mapView.addAnnotation(london)
            
            
            var zoomRect: MKMapRect = MKMapRect.null
            for annotation in mapView.annotations {
                    let annotationPoint = MKMapPoint(annotation.coordinate)
                    let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
                    zoomRect = zoomRect.union(pointRect)
            }
            // mapView.setVisibleMapRect(zoomRect, animated: true)
            
            self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
            
            
            self.locManager.stopUpdatingLocation()
        }
    }
    
}
