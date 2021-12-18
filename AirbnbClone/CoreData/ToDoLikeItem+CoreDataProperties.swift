//
//  ToDoLikeItem+CoreDataProperties.swift
//  AirbnbClone
//
//  Created by Владислав Матыгин on 17.12.2021.
//
//

import Foundation
import CoreData
import UIKit


extension ToDoLikeItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoLikeItem> {
        return NSFetchRequest<ToDoLikeItem>(entityName: "ToDoLikeItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var floorId: String?
    @NSManaged public var isLiked: NSNumber
}

extension ToDoLikeItem : Identifiable {

}
