//
//  ExcursionsSearchViewModel.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 15.03.2023.
//

import Foundation

// MARK: - ExcursionsSearchViewModelOutput

protocol ExcursionsSearchViewModelOutput: AnyObject {
    func loadExcursionsByTitle(includeInTitle text: String)
}

// MARK: - ExcursionsSearchViewModelInput

protocol ExcursionsSearchViewModelInput: AnyObject {
    func makeDelayForLoad(for text: String)
}

// MARK: - ExcursionsSearchViewModel

// Вью-модель, которая сохраняет свое состояние, тем самым добавляет задержку к отправлению текста с SearchBarа в API
final class ExcursionsSearchViewModel: NSObject, ExcursionsSearchViewModelInput {
    weak var output: ExcursionsSearchViewModelOutput?

    func makeDelayForLoad(for text: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(search(_:)), with: text, afterDelay: TimeInterval(ExcursionsListConstants.Api.searchDelay))
    }

    @objc func search(_ text: String) {
        output?.loadExcursionsByTitle(includeInTitle: text)
    }
}
