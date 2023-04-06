//
//  ExcursionsListInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ExcursionsListInteractorOutput

protocol ExcursionsListInteractorOutput: AnyObject {
    func didLoadExcursionsList(excursions: PreviewExcursions)

    func didLoadUserInstance(user: UserData?)

    func getNetworkError()

    func showActivity()
}

// MARK: - ExcursionsListInteractorInput

protocol ExcursionsListInteractorInput: AnyObject {
    func loadExcursionsList()

    func loadUserInstance() // Загрузка экземляра пользователя из хранилища

    func startSearchExcursions(by text: String)

    func clearSearchTextQueryParameter() // Очистить параметры поиска

    func addDistanceFilterParameter(parameter: DistanceFilter) // Добавить параметры фильтра по дистанции к запросу
}
