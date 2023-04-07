//
//  ExcursionsListPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - DistanceFilter

enum DistanceFilter: String {
    case all = "Все"
    case from1To3 = "1-3 км"
    case from3To6 = "3-6 км"
    case from6To10 = "6-10 км"
}

// MARK: - TimeFilter

enum TimeFilter: String {
    case all = "Все"
    case from30mTo60m = "30-60 мин"
    case from1hTo2h = "1-2 ч"
    case from2hTo3h = "2-3 ч"
}

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

    // Параметры для фильтра "Длина маршрута"
    private let distances: [DistanceFilter] = [.all, .from1To3, .from3To6, .from6To10]
    private var selectedDistance: DistanceFilter = .all

    // Параметры для фильтра "Время прогулки"
    private let times: [TimeFilter] = [.all, .from30mTo60m, .from1hTo2h, .from2hTo3h]
    private var selectedTime: TimeFilter = .all

    // Параметры для фильтра "Рейтинг"

    // MARK: - Lifecycle

    init(interactor: ExcursionsListInteractorInput,
         router: ExcursionsListRouterInput,
         moduleOutput: ExcursionsListModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput

        NotificationCenter.default.addObserver(self, selector: #selector(setLikeStatus), name: Notification.Name(NotificationsConstants.Excursions.name), object: nil)
    }
}

extension ExcursionsListPresenter: ExcursionsListModuleInput {
}

// MARK: ExcursionsListViewOutput

extension ExcursionsListPresenter: ExcursionsListViewOutput {
    func didDistanceFilterButtonTapped(with title: String) {
        guard let selectedParameter = DistanceFilter(rawValue: title) else { return }
        selectedDistance = selectedParameter
    }

    func didTimeFilterButtonTapped(with title: String) {
        guard let selectedParameter = TimeFilter(rawValue: title) else { return }
        selectedTime = selectedParameter
    }

    func didFilterSubmitButtonTapped() {
        interactor.addDistanceFilterParameter(parameter: selectedDistance)
        interactor.addTimeFilterParameter(parameter: selectedTime)
        interactor.loadExcursionsList()
    }

    func getDistanceFilterButtons() -> [FilterButtonViewModel] {
        distances.map { [weak self] distance in
            FilterButtonViewModel(title: distance.rawValue, isSelected: distance == self?.selectedDistance)
        }
    }

    func getTimesFilterButtons() -> [FilterButtonViewModel] {
        times.map { [weak self] t in
            FilterButtonViewModel(title: t.rawValue, isSelected: t == self?.selectedTime)
        }
    }

    func didTextTyping(with text: String) {
        interactor.startSearchExcursions(by: text)
    }

    func didClearSearchBar() {
        interactor.clearSearchTextQueryParameter()
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
