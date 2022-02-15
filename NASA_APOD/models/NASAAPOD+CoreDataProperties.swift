//
//  NASA+CoreDataProperties.swift
//  NASA_APOD
//
//  Created by Tharani on 15/02/22.
//
//

import Foundation
import CoreData


extension NASAAPOD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NASAAPOD> {
        return NSFetchRequest<NASAAPOD>(entityName: "NASAAPOD")
    }

    @NSManaged public var titles: String?
    @NSManaged public var descriptionss: String?
    @NSManaged public var dates: String?
    @NSManaged public var lastUpdateDates: Date?

}

