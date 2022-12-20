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
    func didRepeatButtonTapped() {
        interactor.loadExcursionsList()
    }

    func didSelectCell(at indexPath: IndexPath) {
        moduleOutput?.excursionsListModuleWantsToOpenMapDetailModule(excursion: excursions[indexPath.row])
    }

    func didLoadView() {
        interactor.loadExcursionsList()
        view.startLoader() // Запуск анимации лоадера
    }

    func item(for index: Int) -> ExcursionViewModel {
        NotificationCenter.default.addObserver(self, selector: #selector(setLikeStatus), name: Notification.Name(NotificationsConstants.Excursions.name), object: nil)
        return factory.getExcursionViewModel(for: excursions[index])
    }

    func itemsCount() -> Int {
        excursions.count
    }

    @objc func setLikeStatus(_ notification: Notification) {
        guard let id = notification.userInfo?[NotificationsConstants.Excursions.UserInfoKeys.id] as? Int else {
            return
        }
        guard let isLiked = notification.userInfo?[NotificationsConstants.Excursions.UserInfoKeys.isLiked] as? Bool else {
            return
        }
        if let row = excursions.firstIndex(where: { $0.id == id }) {
            excursions[row].isFavorite = isLiked
        }
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
