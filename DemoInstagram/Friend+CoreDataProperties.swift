//
//  Friend+CoreDataProperties.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-01.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var friendUser: User?

}
