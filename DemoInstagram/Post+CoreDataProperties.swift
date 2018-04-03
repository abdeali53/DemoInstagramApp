//
//  Post+CoreDataProperties.swift
//  DemoInstagram
//
//  Created by MacStudent on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var postdate: NSDate?
    @NSManaged public var postimage: NSData?
    @NSManaged public var comment: String?
    @NSManaged public var postComment: NSSet?
    @NSManaged public var postUser: User?

}

// MARK: Generated accessors for postComment
extension Post {

    @objc(addPostCommentObject:)
    @NSManaged public func addToPostComment(_ value: Comment)

    @objc(removePostCommentObject:)
    @NSManaged public func removeFromPostComment(_ value: Comment)

    @objc(addPostComment:)
    @NSManaged public func addToPostComment(_ values: NSSet)

    @objc(removePostComment:)
    @NSManaged public func removeFromPostComment(_ values: NSSet)

}
