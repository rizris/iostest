//
//  RZUsers+CoreDataProperties.swift
//  
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/16/18.
//
//

import Foundation
import CoreData


extension RZUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RZUsers> {
        return NSFetchRequest<RZUsers>(entityName: "RZUsers")
    }

    @NSManaged public var user_name: String?
    @NSManaged public var user_id: Int32
    @NSManaged public var user_username: String?
    @NSManaged public var user_email: String?
    @NSManaged public var user_street: String?
    @NSManaged public var user_suite: String?
    @NSManaged public var user_city: String?
    @NSManaged public var user_zipcode: String?
    @NSManaged public var user_lat: String?
    @NSManaged public var user_lng: String?
    @NSManaged public var user_phone: String?
    @NSManaged public var user_web: String?
    @NSManaged public var user_companyname: String?
    @NSManaged public var user_catchphrase: String?
    @NSManaged public var user_bs: String?

}
