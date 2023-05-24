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
        AppDelegate.sharedAppDelegate
    }

    private var context: NSManagedObjectContext {
        appDelegate.coreDataStack.managedContext
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
        _ ownerRoleDescription: String?,
        _ userId: Int16
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
        favouriteExcursion.datetime = Date()
        favouriteExcursion.userId = userId

        appDelegate.coreDataStack.saveContext()
    }

    // Получение избранных экскурсий по id пользователя
    public func fetchFavouritesExcursions(for userId: Int16) -> [FavouriteExcursion] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        fetchRequest.predicate = NSPredicate(format: "userId == %@", String(userId))
        let sortDescriptor = NSSortDescriptor(key: "datetime", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            return (try? context.fetch(fetchRequest) as? [FavouriteExcursion]) ?? []
        }
    }

    public func fetchFavouriteExcursion(with excursionId: Int16, for userId: Int16) -> FavouriteExcursion? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        let ecxursionIdPredicate = NSPredicate(format: "id = %@", String(excursionId))
        let userIdPredicate = NSPredicate(format: "userId = %@", String(userId))
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [ecxursionIdPredicate, userIdPredicate])
        fetchRequest.predicate = andPredicate
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
        appDelegate.coreDataStack.saveContext()
    }

    public func deleteFavouriteExcursion(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteExcursion")
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        do {
            guard let excursions = try? context.fetch(fetchRequest) as? [FavouriteExcursion],
                  let excursion = excursions.first else { return }

            context.delete(excursion)
        }
        appDelegate.coreDataStack.saveContext()
    }
}
