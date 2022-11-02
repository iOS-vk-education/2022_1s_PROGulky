//
//  AddPlaceBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - AddPlaceModuleBuilder

final class AddPlaceModuleBuilder {
    func build() -> UIViewController {
        let viewController = AddPlaceViewController()
        let router = AddPlaceRouter()
        let interactor = AddPlaceInteractor()

        let presenter = AddPlacePresenter(interactor: interactor, router: router)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
