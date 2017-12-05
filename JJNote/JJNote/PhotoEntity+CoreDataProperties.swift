//
//  PhotoEntity+CoreDataProperties.swift
//  JJNote
//
//  Created by MAC on 2017-04-09.
//  Copyright © 2017 MAC. All rights reserved.
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var image: NSData?
    @NSManaged public var note_relationship: NSSet?

}

// MARK: Generated accessors for note_relationship
extension PhotoEntity {

    @objc(addNote_relationshipObject:)
    @NSManaged public func addToNote_relationship(_ value: NoteEntity)

    @objc(removeNote_relationshipObject:)
    @NSManaged public func removeFromNote_relationship(_ value: NoteEntity)

    @objc(addNote_relationship:)
    @NSManaged public func addToNote_relationship(_ values: NSSet)

    @objc(removeNote_relationship:)
    @NSManaged public func removeFromNote_relationship(_ values: NSSet)

}
