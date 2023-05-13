//
//  MapDetailRouterInput.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

import Foundation

protocol MapDetailRouterInput: AnyObject {
    func embedMapModule(output: MapModuleOutput)
    func embedDetailModule()
}
