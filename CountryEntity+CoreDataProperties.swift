//
//  CountryEntity+CoreDataProperties.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//
//

import Foundation
import CoreData


extension CountryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryEntity> {
        return NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
    }

    @NSManaged public var alpha2code: String?
    @NSManaged public var capital: String?
    @NSManaged public var currencyCode: String?
    @NSManaged public var currencyName: String?
    @NSManaged public var currencySymbol: String?
    @NSManaged public var flag: String?
    @NSManaged public var name: String?

}

extension CountryEntity : Identifiable {

}
