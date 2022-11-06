//
//  MainTabBarController.swift
//  PROGulky
//
//  Created by Сергей Киселев on 23.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Properties

    var dataSource = [String]()
    var selectedButton = UIButton()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    // MARK: - UI Setup

    func makeUI() {
        UITabBar.appearance().tintColor = UIColor(hexString: "#92FDB0")
        tabBar.backgroundColor = .white

        let firstVC = UIViewController()
        firstVC.view.backgroundColor = UIColor(hexString: "#92FDB0")
        firstVC.tabBarItem.title = ""
        firstVC.tabBarItem.selectedImage = UIImage(named: "Home-Active")
        firstVC.tabBarItem.image = UIImage(named: "Home")

        let secondVC = UIViewController()
        secondVC.view.backgroundColor = UIColor(hexString: "#94E8FC")
        secondVC.tabBarItem.title = ""
        secondVC.tabBarItem.selectedImage = UIImage(named: "Likes-Active")
        secondVC.tabBarItem.image = UIImage(named: "Likes")

        var thirdVC = UIViewController()
        thirdVC = ProfileViewController()
        thirdVC.view.backgroundColor = .white
        thirdVC.tabBarItem.title = ""
        thirdVC.tabBarItem.selectedImage = UIImage(named: "Profile-Active")
        thirdVC.tabBarItem.image = UIImage(named: "Profile")

        viewControllers = [firstVC, secondVC, thirdVC]

        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = 10
        tabBar.layer.cornerRadius = 16
    }
}
