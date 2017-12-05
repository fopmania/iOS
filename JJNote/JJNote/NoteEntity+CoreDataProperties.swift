//
//  NoteEntity+CoreDataProperties.swift
//  JJNote
//
//  Created by MAC on 2017-04-09.
//  Copyright © 2017 MAC. All rights reserved.
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var note: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var photo_relationship: NSSet?

}

// MARK: Generated accessors for photo_relationship
extension NoteEntity {

    @objc(addPhoto_relationshipObject:)
    @NSManaged public func addToPhoto_relationship(_ value: PhotoEntity)

    @objc(removePhoto_relationshipObject:)
    @NSManaged public func removeFromPhoto_relationship(_ value: PhotoEntity)

    @objc(addPhoto_relationship:)
    @NSManaged public func addToPhoto_relationship(_ values: NSSet)

    @objc(removePhoto_relationship:)
    @NSManaged public func removeFromPhoto_relationship(_ values: NSSet)

}
