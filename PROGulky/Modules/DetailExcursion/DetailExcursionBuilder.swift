//
//  DetailExcursionBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - DetailExcursionModuleBuilder

final class DetailExcursionModuleBuilder {
    private let excursion: Excursion
    private weak var moduleOutput: DetailExcursionModuleOutput?

    init(excursion: Excursion, moduleOutput: DetailExcursionModuleOutput) {
        self.excursion = excursion
        self.moduleOutput = moduleOutput
    }

    func build() -> UIViewController {
        guard let moduleOutput else { return UIViewController() }
        let viewController = DetailExcursionViewController()
        let router = DetailExcursionRouter()
        let interactor = DetailExcursionInteractor()

        let presenter = DetailExcursionPresenter(
            interactor: interactor,
            router: router,
            excursion: excursion,
            moduleOutput: moduleOutput
        )
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
