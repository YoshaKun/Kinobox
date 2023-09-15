//
//  Artist+CoreDataProperties.swift
//  M20_LocalSaveData
//
//  Created by Yosha Kun on 15.09.2023.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var country: String?
    @NSManaged public var dateOfBorn: String?
    @NSManaged public var secondName: String?
    @NSManaged public var firstName: String?

}

extension Artist : Identifiable {

}
