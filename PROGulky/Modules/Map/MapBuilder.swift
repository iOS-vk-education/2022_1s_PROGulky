//
//  MapBuilder.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 21/11/2022.
//

import UIKit

// MARK: - MapModuleBuilder

final class MapModuleBuilder {
    func build(_ excursion: Excursion) -> UIViewController {
        let viewController = MapViewController()
        let router = MapRouter()
        let interactor = MapInteractor()

        let presenter = MapPresenter(interactor: interactor, router: router, excursion: excursion)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
