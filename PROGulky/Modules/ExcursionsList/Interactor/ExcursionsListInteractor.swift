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
        ExcursionsRepository.shared.getExcursionsList { [weak self] excursions in
            switch excursions {
            case let .success(excursions):
                self?.output?.didLoadExcursionsList(excursions: excursions)
            case .failure:
                self?.output?.getNetworkError()
            }
        }
    }
}
