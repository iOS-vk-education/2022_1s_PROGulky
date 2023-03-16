//
//  ExcursionsListInteractor.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//
import Foundation

// MARK: - ExcursionsListInteractor

final class ExcursionsListInteractor {
    weak var output: ExcursionsListInteractorOutput?

    private let search: ExcursionsSearchViewModelInput

    init(searchVM: ExcursionsSearchViewModelInput) {
        search = searchVM
    }
}

// MARK: ExcursionsListInteractorInput

extension ExcursionsListInteractor: ExcursionsListInteractorInput {
    func loadUserInstance() {
        let user = UserData(name: "Semyon", email: "email", token: "1234", role: "user")
        output?.didLoadUserInstance(user: user)
    }

    func loadExcursionsList() {
        ExcursionsRepository.shared.getExcursionsList(
            completion: { [weak self] excursions in
                switch excursions {
                case let .success(excursions):
                    self?.output?.didLoadExcursionsList(excursions: excursions)
                case .failure:
                    self?.output?.getNetworkError()
                }
            },
            params: nil
        )
    }

    func startSearchExcursions(by text: String) {
        search.makeDelayForLoad(for: text)
        output?.showActivity() // Показываю активити когда происходит запрос
    }
}

// MARK: ExcursionsSearchViewModelOutput

extension ExcursionsListInteractor: ExcursionsSearchViewModelOutput {
    func loadExcursionsByTitle(includeInTitle text: String) {
        let searchQuery = [ExcursionsListConstants.Api.searchQueryParameterKey: text]
        let params = [searchQuery]

        ExcursionsRepository.shared.getExcursionsList(
            completion: { [weak self] excursions in
                switch excursions {
                case let .success(excursions):
                    self?.output?.didLoadExcursionsList(excursions: excursions)
                case .failure:
                    self?.output?.getNetworkError()
                }
            },
            params: params
        )
    }
}
