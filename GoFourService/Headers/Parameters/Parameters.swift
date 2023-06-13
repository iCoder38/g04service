//
//  Parameters.swift
//  KamCash
//
//  Created by Apple on 16/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit


//MARK: - CATEGORY -
struct car_list_category_params: Encodable {
    
    let action: String
}

//MARK: - CART LIST -
struct get_cart_params: Encodable {
    
    let action: String
    let userId:String
}

//MARK: - CART LIST -
struct cart_list_params: Encodable {
    
    let action: String
    let userId:String
    let foodId:String
    let quantity:String
}

//MARK: - ADDRESS LIST -
struct address_list_params: Encodable {
    
    let action: String
    let userId:String
}

//MARK: - ADD ADDRESS -
struct add_address_params: Encodable {
    
    let action: String
    let userId:String
    let firstName:String
    let lastName:String
    let mobile:String
    let address:String
    let City:String
    let state:String
    let Zipcode:String
    let company:String
    let country:String
}

//MARK: - CARD LIST -
struct card_list_params: Encodable {
    
    let action: String
    let userId:String
    let pageNo:String
}

//[action] => getprice
//    [pickuplatLong] => 28.6634356,77.3240323
//    [droplatLong] => 28.6634636,77.3240105
//    [categoryId] => 1

//MARK: - HELP -
struct HelpWB: Encodable {
   let action: String
}

//MARK: - GET DISTANCE FARE PRICE -
struct get_fare_price_params: Encodable {
    let action: String
    let pickuplatLong: String
    let droplatLong: String
    let categoryId: String
}

//MARK: - ADD BOOKING -
struct add_booking_params: Encodable {
    let action: String
    let userId: String
    let categoryId: String
    let RequestPickupAddress: String
    let RequestPickupLatLong: String
    let RequestDropAddress: String
    let RequestDropLatLong: String
    let duration: String
    let distance: String
    let total: String
}

//MARK: - profile -
struct edit_profile_for_lat_long_params: Encodable {
    let action: String
    let userId: String
    let latitude: String
    let longitude: String
    
}

/*
 [action] => driverconfirm
     [driverId] => 42
     [bookingId] => 86
 */
//MARK: - profile -
struct driver_accept_request: Encodable {
    let action: String
    let driverId: String
    let bookingId: String
    
}

//MARK: - driver arrived -
struct driver_arrived_params: Encodable {
    let action: String
    let driverId: String
    let bookingId: String
    
}

//MARK: - driver start ride -
struct driver_start_ride_params: Encodable {
    let action: String
    let driverId: String
    let bookingId: String
    let Actual_PickupAddress: String
    let Actual_Pickup_Lat_Long: String
}

//MARK: - driver ride end -
struct driver_end_ride_params: Encodable {
    let action: String
    let driverId: String
    let bookingId: String
    let Actual_Drop_Address: String
    let Actual_Drop_Lat_Long: String
}

/*
 [action] => addbooking
     [userId] => 45
     [categoryId] => 1
     [RequestPickupAddress] => 9/1, Block C, Yojna Vihar, Anand Vihar, Ghaziabad, Uttar Pradesh 110092, India
     [RequestPickupLatLong] => 28.6634356,77.3240323
     [RequestDropAddress] => 9/1, Block C, Yojna Vihar, Anand Vihar, Ghaziabad, Uttar Pradesh 110092, India
     [RequestDropLatLong] => 28.6634636,77.3240105
     [duration] => 1 min
     [distance] => 1
     [total] => 5
 */
class Parameters: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
