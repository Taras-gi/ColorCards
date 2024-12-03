//
//  ColorHex+CoreDataProperties.swift
//  
//
//  Created by Suraj Bhatt on 03/12/24.
//
//

import Foundation
import CoreData


extension ColorHex {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorHex> {
        return NSFetchRequest<ColorHex>(entityName:Constant.CoreData.entityName)
    }

    @NSManaged public var colorCode: String?
    @NSManaged public var isSynced: Bool
    @NSManaged public var timeStamp: Date?
}
