//
//  ExcursionsSearchHelper.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 15.03.2023.
//

import Foundation

// MARK: - ExcursionsSearchHelperOutput

protocol ExcursionsSearchHelperOutput: AnyObject {
    func addSearchText(text: String)
}

// MARK: - ExcursionsSearchHelperInput

protocol ExcursionsSearchHelperInput: AnyObject {
    func makeDelayForLoad(for text: String)
}

// MARK: - ExcursionsSearchHelper

// Хелпер, который сохраняет свое состояние, тем самым добавляет задержку к отправлению текста с SearchBarа в API
final class ExcursionsSearchHelper: NSObject, ExcursionsSearchHelperInput {
    weak var output: ExcursionsSearchHelperOutput?

    func makeDelayForLoad(for text: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(search(_:)), with: text, afterDelay: TimeInterval(ExcursionsRepositoryConstants.Search.delay))
    }

    @objc func search(_ text: String) {
        output?.addSearchText(text: text)
    }
}
