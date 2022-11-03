//
//  DetailExcursionPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - DetailExcursionPresenter

final class DetailExcursionPresenter {
    // MARK: - Public Properties

    weak var view: DetailExcursionViewInput!

    // MARK: - Private Properties

    private let interactor: DetailExcursionInteractorInput
    private let router: DetailExcursionRouterInput

    // MARK: - Lifecycle

    init(interactor: DetailExcursionInteractorInput, router: DetailExcursionRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension DetailExcursionPresenter: DetailExcursionModuleInput {
}

extension DetailExcursionPresenter: DetailExcursionViewOutput {
}

extension DetailExcursionPresenter: DetailExcursionInteractorOutput {
}
