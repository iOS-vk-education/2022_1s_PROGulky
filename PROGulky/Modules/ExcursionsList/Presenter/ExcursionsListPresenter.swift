//
//  ExcursionsListPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ExcursionsListPresenter

final class ExcursionsListPresenter {
    // MARK: - Public Properties

    weak var view: ExcursionsListViewInput!
    weak var moduleOutput: ExcursionsListModuleOutput?

    // MARK: - Private Properties

    private let interactor: ExcursionsListInteractorInput
    private let router: ExcursionsListRouterInput

    private let factory = ExcursionsListDisplayDataFactory()
    private var excursions: [Excursion] = []

    // MARK: - Lifecycle

    init(interactor: ExcursionsListInteractorInput,
         router: ExcursionsListRouterInput,
         moduleOutput: ExcursionsListModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput
    }
}

extension ExcursionsListPresenter: ExcursionsListModuleInput {
}

// MARK: ExcursionsListViewOutput

extension ExcursionsListPresenter: ExcursionsListViewOutput {
    func didRepeatButtonPressed() {
        interactor.loadExcursionsList()
    }

    func didSelectCell(at indexPath: IndexPath) {
        moduleOutput?.excursionsListModuleWantsToOpenDetailExcursion(excursion: excursions[indexPath.row])
    }

    func didLoadView() {
        interactor.loadExcursionsList()
        view.startLoader() // Запуск анимации лоадера
//      excursions = factory.setExcursionsListDisplayData()
    }

    func item(for index: Int) -> ExcursionViewModel {
        factory.getExcursionViewModel(for: excursions[index])
    }

    func itemsCount() -> Int {
        excursions.count
    }
}

// MARK: ExcursionsListInteractorOutput

extension ExcursionsListPresenter: ExcursionsListInteractorOutput {
    func getNetworkError() {
        view.showErrorView()
    }

    func didLoadExcursionsList(excursions: Excursions) {
        self.excursions = excursions
        view.reloadView() // Перезагрузить тейбл вью
        view.stopLoader() // Выключить анимацию лоадера
    }
}
