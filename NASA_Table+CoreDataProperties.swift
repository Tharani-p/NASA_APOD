//
//  NASA_Table+CoreDataProperties.swift
//  NASA_APOD
//
//  Created by Tharani on 15/02/22.
//
//

import Foundation
import CoreData


extension NASA_Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NASA_Table> {
        return NSFetchRequest<NASA_Table>(entityName: "NASA_Table")
    }

    @NSManaged public var date: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var lastUpdateDate: Date?
    @NSManaged public var title: String?

}

extension NASA_Table : Identifiable {

}
