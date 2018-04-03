//
//  User+CoreDataProperties.swift
//  DemoInstagram
//
//  Created by MacStudent on 2018-04-03.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var describe: String?
    @NSManaged public var userFriend: NSSet?
    @NSManaged public var userPost: NSSet?

}

// MARK: Generated accessors for userFriend
extension User {

    @objc(addUserFriendObject:)
    @NSManaged public func addToUserFriend(_ value: Friend)

    @objc(removeUserFriendObject:)
    @NSManaged public func removeFromUserFriend(_ value: Friend)

    @objc(addUserFriend:)
    @NSManaged public func addToUserFriend(_ values: NSSet)

    @objc(removeUserFriend:)
    @NSManaged public func removeFromUserFriend(_ values: NSSet)

}

// MARK: Generated accessors for userPost
extension User {

    @objc(addUserPostObject:)
    @NSManaged public func addToUserPost(_ value: Post)

    @objc(removeUserPostObject:)
    @NSManaged public func removeFromUserPost(_ value: Post)

    @objc(addUserPost:)
    @NSManaged public func addToUserPost(_ values: NSSet)

    @objc(removeUserPost:)
    @NSManaged public func removeFromUserPost(_ values: NSSet)

}
