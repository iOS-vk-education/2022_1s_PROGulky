//
//  ExcursionsListPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ExcursionsListPresenter

final class ExcursionsListPresenter {
    // MARK: - Public Properties

    weak var view: ExcursionsListViewInput!

    // MARK: - Private Properties

    private let interactor: ExcursionsListInteractorInput
    private let router: ExcursionsListRouterInput


    //MARK: - Lifecycle

    init(interactor: ExcursionsListInteractorInput, router: ExcursionsListRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension ExcursionsListPresenter: ExcursionsListModuleInput {
}

extension ExcursionsListPresenter: ExcursionsListViewOutput {
}

extension ExcursionsListPresenter: ExcursionsListInteractorOutput {
}