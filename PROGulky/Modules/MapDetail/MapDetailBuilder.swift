//
//  MapDetailBuilder.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

import UIKit

// MARK: - MapDetailModuleBuilder

final class MapDetailModuleBuilder {
    func build(moduleOutput: MapDetailModuleOutput, excursion: Excursion) -> UIViewController {
        let viewController = MapDetailViewController()
        let router = MapDetailRouter(viewController, excursion: excursion)
        let interactor = MapDetailInteractor()

        let presenter = MapDetailPresenter(interactor: interactor, router: router, output: moduleOutput)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
