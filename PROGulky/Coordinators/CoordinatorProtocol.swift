//
//  CoordinatorProtocol.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import UIKit
protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get }
    func start(animated: Bool)
}
