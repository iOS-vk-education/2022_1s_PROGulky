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
    private var excursions: [PreviewExcursion] = []

    private var distanceFilterButtons: [Int: ChipsButton] // Кнопки фильтров дистанции
    private var idSelectedDistanceFilterButton: Int? // Айди выбранного фильтра дистанции

    // MARK: - Lifecycle

    init(interactor: ExcursionsListInteractorInput,
         router: ExcursionsListRouterInput,
         moduleOutput: ExcursionsListModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput

        distanceFilterButtons = factory.getDistanceFilterParameters()

        NotificationCenter.default.addObserver(self, selector: #selector(setLikeStatus), name: Notification.Name(NotificationsConstants.Excursions.name), object: nil)
    }
}

extension ExcursionsListPresenter: ExcursionsListModuleInput {
}

// MARK: ExcursionsListViewOutput

extension ExcursionsListPresenter: ExcursionsListViewOutput {
    func didFilterSubmitButtonTapped() {
        guard let id = idSelectedDistanceFilterButton else { return }
        guard let params = distanceFilterButtons[id]?.apiParameters else { return }

        interactor.loadExcursionsByFilters(by: params)
    }

    func didDistanceFilterButtonTapped(on id: Int) {
        if let idSelectedFilterButton = idSelectedDistanceFilterButton {
            distanceFilterButtons[id]?.changeColor() // Включается выбираемая
            distanceFilterButtons[idSelectedFilterButton]?.changeColor() // Выключается выбранная
        } else {
            distanceFilterButtons[id]?.changeColor()
        }
        idSelectedDistanceFilterButton = id
    }

    func getDistanceFilterButtons() -> [Int: ChipsButton] {
        distanceFilterButtons
    }

    func didTextTyping(with text: String) {
        interactor.startSearchExcursions(by: text)
    }

    func didClearSearchBar() {
        interactor.loadExcursionsList()
    }

    func didAddExcursionButtonTapped() {
        guard UserAuthService.shared.isLogged else {
            view.showAuthView()
            return
        }
        moduleOutput?.excursionsListModuleWantsToOpenAddExcursion()
    }

    func didRepeatButtonTapped() {
        interactor.loadExcursionsList()
    }

    func didSelectCell(at indexPath: IndexPath) {
        moduleOutput?.excursionsListModuleWantsToOpenMapDetailModule(excursion: excursions[indexPath.row])
    }

    func didLoadView() {
        interactor.loadExcursionsList()
        interactor.loadUserInstance()
        view.startLoader() // Запуск анимации лоадера
    }

    func item(for index: Int) -> ExcursionViewModel {
        factory.getExcursionViewModel(for: excursions[index])
    }

    func itemsCount() -> Int {
        excursions.count
    }

    // TODO: простановка лайка должна быть реализована по другому
    @objc func setLikeStatus(_ notification: Notification) {
        guard let id = notification.userInfo?[NotificationsConstants.Excursions.UserInfoKeys.id] as? Int else {
            return
        }
        guard let isLiked = notification.userInfo?[NotificationsConstants.Excursions.UserInfoKeys.isLiked] as? Bool else {
            return
        }
        if let row = excursions.firstIndex(where: { $0.id == id }) {
        }
    }
}

// MARK: ExcursionsListInteractorOutput

extension ExcursionsListPresenter: ExcursionsListInteractorOutput {
    func showActivity() {
        view.startLoader()
    }

    func getNetworkError() {
        excursions = []

        // TODO: брать ошибки с API
        let error = NSError(domain: "Ошибка сети", code: 400)

        view.showErrorView(with: error)
        view.reloadView() // Перезагрузить тейбл вью
    }

    func didLoadExcursionsList(excursions: PreviewExcursions) {
        self.excursions = excursions
        view.hideErrorView() // Скрыть сообщение об ошибках
        view.reloadView() // Перезагрузить тейбл вью
        view.stopLoader() // Выключить анимацию лоадера
    }

    func didLoadUserInstance(user: UserData?) {
        let viewModel = factory.getGreetingViewModel(for: user)
        view.configureGreetingMessage(with: viewModel)
    }
}
