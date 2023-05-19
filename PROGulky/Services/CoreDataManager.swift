//
//  CoreDataManager.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 19.05.2023.
//

import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    override private init() {}

    private var appDelegate: AppDelegate {
        // swiftlint:disable:next force_cast
        UIApplication.shared.delegate as! AppDelegate
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    public func addFavouriteExcursion(
        _ id: Int16,
        _ title: String?,
        _ desc: String?,
        _ image: String?,
        _ rating: Double,
        _ duration: Int16,
        _ distance: Double,
        _ numberOfPoints: Int16,
        _ ownerId: Int16,
        _ ownerName: String?,
        _ ownerImage: String?,
        _ ownerRoleId: Int16,
        _ ownerRoleValue: String?,
        _ ownerRoleDescription: String?
    ) {
        guard let favouriteExcursionEntity = NSEntityDescription.entity(forEntityName: "FavouriteExcursion", in: context)
        else { return }
        let favouriteExcursion = FavouriteExcursion(
            entity: favouriteExcursionEntity,
            insertInto: context
        )

        favouriteExcursion.id = id
        favouriteExcursion.title = title
        favouriteExcursion.desc = desc
        favouriteExcursion.image = image
        favouriteExcursion.rating = rating
        favouriteExcursion.duration = duration
        favouriteExcursion.distance = distance
        favouriteExcursion.numberOfPoints = numberOfPoints
        favouriteExcursion.ownerId = ownerId
        favouriteExcursion.ownerName = ownerName
        favouriteExcursion.ownerImage = ownerImage
        favouriteExcursion.ownerRoleId = ownerRoleId
        favouriteExcursion.ownerRoleValue = ownerRoleValue
        favouriteExcursion.ownerRoleDescription = ownerRoleDescription

        appDelegate.saveContext()
    }

    public func fetchFavouritesExcursions() -> [FavouriteExcursion] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        do {
            return (try? context.fetch(fetchRequest) as? [FavouriteExcursion]) ?? []
        }
    }

    public func fetchFavouriteExcursion(with id: Int16) -> FavouriteExcursion? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        do {
            guard let excursions = try? context.fetch(fetchRequest) as? [FavouriteExcursion],
                  let excursion = excursions.first else { return nil }
            return excursion
        }
    }

    public func deleteAllFavouritesExcursions() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        do {
            let excursions = try? context.fetch(fetchRequest) as? [FavouriteExcursion]
            excursions?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }

    public func deleteFavouriteExcursion(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        do {
            guard let excursions = try? context.fetch(fetchRequest) as? [FavouriteExcursion],
                  let excursion = excursions.first else { return }

            context.delete(excursion)
        }
        appDelegate.saveContext()
    }
}
