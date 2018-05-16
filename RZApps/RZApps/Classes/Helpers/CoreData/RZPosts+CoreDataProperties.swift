//
//  RZPosts+CoreDataProperties.swift
//  
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/16/18.
//
//

import Foundation
import CoreData


extension RZPosts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RZPosts> {
        return NSFetchRequest<RZPosts>(entityName: "RZPosts")
    }

    @NSManaged public var postbody: String?
    @NSManaged public var postid: Int32
    @NSManaged public var posttitle: String?
    @NSManaged public var postuserid: Int32

}
