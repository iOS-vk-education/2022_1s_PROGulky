//
//  ExcursionsListInteractor.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ExcursionsListInteractor

final class ExcursionsListInteractor {
    weak var output: ExcursionsListInteractorOutput?
}

// MARK: ExcursionsListInteractorInput

extension ExcursionsListInteractor: ExcursionsListInteractorInput {
    func loadExcursionsList() {
        ApiManager.shared.getExcursions { [weak self] excursions in
            switch excursions {
            case let .success(excursions):
                self?.output?.didLoadExcursionsList(excursions: excursions)
            case let .failure(error):
                self?.output?.getNetworkError()
                print("error", error)
            }
        }
    }
}
