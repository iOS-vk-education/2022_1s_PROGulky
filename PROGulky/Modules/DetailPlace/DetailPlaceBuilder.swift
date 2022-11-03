//
//  DetailPlaceBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - DetailPlaceModuleBuilder

final class DetailPlaceModuleBuilder {
    func build() -> UIViewController {
        let viewController = DetailPlaceViewController()
        let router = DetailPlaceRouter()
        let interactor = DetailPlaceInteractor()

        let presenter = DetailPlacePresenter(interactor: interactor, router: router)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
