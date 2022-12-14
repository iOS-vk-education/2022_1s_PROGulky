//
//  AppDelegate.swift
//  PROGulky
//
//  Created by Иван Тазенков on 21.10.2022.
//

import UIKit

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

        return true
    }
}
