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
        return NSFetchRequest<NASA>(entityName: "NASA")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var date: String?
    @NSManaged public var lastUpdateDate: Date?

}

extension NASAAPOD : Identifiable {

}
