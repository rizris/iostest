//
//  RZComments+CoreDataProperties.swift
//  
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/16/18.
//
//

import Foundation
import CoreData


extension RZComments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RZComments> {
        return NSFetchRequest<RZComments>(entityName: "RZComments")
    }

    @NSManaged public var commid: Int32
    @NSManaged public var commpostid: Int32
    @NSManaged public var commname: String?
    @NSManaged public var commemail: String?
    @NSManaged public var commbody: String?

}
