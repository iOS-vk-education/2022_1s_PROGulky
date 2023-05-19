//
//  FavouritesExcursions+CoreDataProperties.swift
//
//
//  Created by Semyon Pyatkov on 19.05.2023.
//
//

import Foundation
import CoreData

public extension FavouritesExcursions {
    @nonobjc class func fetchRequest() -> NSFetchRequest<FavouritesExcursions> {
        NSFetchRequest<FavouritesExcursions>(entityName: "FavouritesExcursions")
    }

    @NSManaged var id: Int16
    @NSManaged var title: String?
    @NSManaged var desc: Int16
    @NSManaged var image: String?
    @NSManaged var rating: Double
    @NSManaged var duration: Int16
    @NSManaged var distance: Double
    @NSManaged var numberOfPoints: Int16
    @NSManaged var ownerId: Int16
    @NSManaged var ownerName: String?
    @NSManaged var ownerImage: String?
    @NSManaged var ownerRoleId: Int16
    @NSManaged var ownerRoleValue: String?
    @NSManaged var ownerRoleDescription: String?
}
