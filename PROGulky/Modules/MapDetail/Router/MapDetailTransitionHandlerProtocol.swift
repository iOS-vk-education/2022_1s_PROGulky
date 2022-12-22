//
//  MapDetailTransitionHandlerProtocol.swift
//  PROGulky
//
//  Created by Иван Тазенков on 29.11.2022.
//

import Foundation
import UIKit

protocol MapDetailTransitionHandlerProtocol: AnyObject {
    func embedMapModule(_ viewController: UIViewController)
    func embedDetailModule(_ viewController: UIViewController)
}
