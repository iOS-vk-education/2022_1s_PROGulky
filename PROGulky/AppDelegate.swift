//
//  AppDelegate.swift
//  PROGulky
//
//  Created by Иван Тазенков on 21.10.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([], animated: false)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        let appCoordinator = AppCoordinator(tabBarController: tabBarController)
        self.appCoordinator = appCoordinator
        appCoordinator.start(animated: false)

        let mapsConfigurator: MapsConfiguratorServiceProtocol = MapsConfiguratorService()
        mapsConfigurator.activateMaps()

        let isDarkMode = UserDefaults.standard.bool(forKey: UserKeys.isDarkMode.rawValue)
        if isDarkMode {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        }

        return true
    }

    // Свойства для CoreData
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            } else {
                print("[DEBUG]: ", description.url?.absoluteString ?? "error")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("[DEBUG]: error save context")
            }
        }
    }
}
