//
//  Establishment+CoreDataProperties.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/18/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//
//

import Foundation
import CoreData


extension Establishment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Establishment> {
        return NSFetchRequest<Establishment>(entityName: "Establishment")
    }

    @NSManaged public var image: Data?
    @NSManaged public var location1: String?
    @NSManaged public var location2: String?
    @NSManaged public var name: String?
    @NSManaged public var location3: String?
    @NSManaged public var fInterest: String?

}
