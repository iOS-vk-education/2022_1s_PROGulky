//
//  MapBuilder.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 21/11/2022.
//

import UIKit

// MARK: - MapModuleBuilder

final class MapModuleBuilder {
    func build(excursion: Excursion) -> UIViewController {
        let viewController = MapViewController()

        let presenter = MapPresenter(
            excursion: excursion
        )
        presenter.view = viewController

        viewController.output = presenter

        return viewController
    }
}
