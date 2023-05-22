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

    lazy var coreDataStack: CoreDataStack = .init(modelName: "CoreData")

    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
        }
        return delegate
    }()

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
}
