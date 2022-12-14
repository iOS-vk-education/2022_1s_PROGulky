//
//  CoordinatorProtocol.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
@objc protocol CoordinatorProtocol: AnyObject {
    func start(animated: Bool)
    @objc optional func finish()
}
