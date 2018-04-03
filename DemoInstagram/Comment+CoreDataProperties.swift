//
//  Comment+CoreDataProperties.swift
//  DemoInstagram
//
//  Created by MacStudent on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var postDate: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var username: String?
    @NSManaged public var commentUser: Post?

}
