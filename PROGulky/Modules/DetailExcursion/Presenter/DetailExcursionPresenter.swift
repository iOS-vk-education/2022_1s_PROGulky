//
//  DetailExcursionPresenter.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 31/10/2022.
//

import Foundation

// MARK: - DetailExcursionPresenter

final class DetailExcursionPresenter {
    // MARK: - Public Properties

    weak var view: DetailExcursionViewInput!

    // MARK: - Private Properties

    private let interactor: DetailExcursionInteractorInput
    private let router: DetailExcursionRouterInput
    private let factory = DetailExcursionDisplayDataFactory()
    private let excursion: Excursion
    private var viewModel: DetailExcursionViewModel
    private weak var moduleOutput: DetailExcursionModuleOutput?

    // MARK: - Lifecycle

    init(interactor: DetailExcursionInteractorInput,
         router: DetailExcursionRouterInput,
         excursion: Excursion,
         moduleOutput: DetailExcursionModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.excursion = excursion
        self.moduleOutput = moduleOutput
        viewModel = factory.setupViewModel(excursion: excursion)
    }
}

extension DetailExcursionPresenter: DetailExcursionModuleInput {
}

// MARK: DetailExcursionViewOutput

extension DetailExcursionPresenter: DetailExcursionViewOutput {
    func didLoadView() {
        view.configure(viewModel: viewModel)
        view.configureLikeButton(isLiked: viewModel.isLiked)
    }

    func didLikeButtonTapped() {
        interactor.didLikeButtonTapped(with: viewModel.id, isLiked: viewModel.isLiked)
    }

    func place(for indexPath: IndexPath) -> PlaceViewModel {
        factory.getPlaceViewModel(for: excursion.places[indexPath.row])
    }

    var placesCount: Int {
        excursion.places.count
    }

    var description: String {
        excursion.description
    }
}

// MARK: DetailExcursionInteractorOutput

extension DetailExcursionPresenter: DetailExcursionInteractorOutput {
    func userChangeStatusLikeView(on status: Bool) {
        view.configureLikeButton(isLiked: status)
        viewModel.isLiked = status
    }

    func userRemoveFromFavoritesExcursions(for id: Int) {
        postNotificationLikeStatus(with: false, for: id)
    }

    func userAddToFavoritesExcursions(for id: Int) {
        postNotificationLikeStatus(with: true, for: id)
    }

    // Ошибка авторизации
    func gotAuthError() {
        view.showAuthView()
    }

    // Ошибка сервера
    func gotAnotherError() {
        view.showErrorView()
    }

    private func postNotificationLikeStatus(with isLiked: Bool, for id: Int) {
        NotificationCenter.default.post(
            name: NSNotification.Name(
                rawValue: NotificationsConstants.Excursions.name),
            object: nil,
            userInfo: [
                NotificationsConstants.Excursions.UserInfoKeys.id: id,
                NotificationsConstants.Excursions.UserInfoKeys.isLiked: isLiked
            ]
        )
    }
}
