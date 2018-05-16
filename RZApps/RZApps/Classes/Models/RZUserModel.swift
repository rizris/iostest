//
//  RZUserModel.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit

class RZUserModel: NSObject {
    
    var user_id: Int!
    var user_name: String!
    var user_username: String!
    var user_email: String!
    var user_street: String!
    var user_suite: String!
    var user_city: String!
    var user_zipcode: String!
    var user_lat: String!
    var user_lng: String!
    var user_phone: String!
    var user_website: String!
    var user_companyname: String!
    var user_catchPhrase: String!
    var user_bs: String!
    
    
    class func GetUserInfo( eUser : [AnyHashable: Any]) -> RZUserModel{
        
        let userRZ  = RZUserModel()
        
        if let userid = eUser["id"] as? Int{
            userRZ.user_id = userid
        }
        if let name = eUser["name"] as? String{
            userRZ.user_name = name
        }
        if let username = eUser["username"] as? String{
            userRZ.user_username = username
        }
        if let email = eUser["email"] as? String{
            userRZ.user_email = email
        }
        if let address = eUser["address"] as? [AnyHashable: Any]{
            if let street = address["street"] as? String{
                userRZ.user_street = street
            }
            if let suite = address["suite"] as? String{
                userRZ.user_suite = suite
            }
            if let city = address["city"] as? String{
                userRZ.user_city = city
            }
            if let zip = address["zipcode"] as? String{
                userRZ.user_zipcode = zip
            }
            
            if let geo = address["geo"] as? [AnyHashable: Any]{
                if let lat = geo["lat"] as? String{
                    userRZ.user_lat = lat
                }
                if let lng = geo["lng"] as? String{
                    userRZ.user_lng = lng
                }
            }
        }
        
        if let phone = eUser["phone"] as? String{
            userRZ.user_phone = phone
        }
        if let website = eUser["website"] as? String{
            userRZ.user_website = website
        }
        
        if let company = eUser["company"] as? [AnyHashable: Any]{
            if let companyname = company["name"] as? String{
                userRZ.user_companyname = companyname
            }
            if let catchPhrase = company["catchPhrase"] as? String{
                userRZ.user_catchPhrase = catchPhrase
            }
            if let bs = company["bs"] as? String{
                userRZ.user_bs = bs
            }
        }
        
        return userRZ
    }
    
    
    

}
