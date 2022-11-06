//
//  AppDelegate.swift
//  PROGulky
//
//  Created by Иван Тазенков on 21.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")

        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}
