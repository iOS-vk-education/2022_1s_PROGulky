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

    private let search: ExcursionsSearchHelperInput

    private var distanceFilterParameters: [String: String]? // Параметры фильтров длины маршрута
    private var timeFilterParameters: [String: String]? // Параметры фильтра времени

    private var filterParameters: [String: String] = [:] // Параметры всех фильтров для поиска
    private var searchText: String? // Параметр (строка) для поиска экскурсии по названию

    init(helper: ExcursionsSearchHelperInput) {
        search = helper
    }
}

// MARK: ExcursionsListInteractorInput

extension ExcursionsListInteractor: ExcursionsListInteractorInput {
    func loadUserInstance() {
        let user = UserData(name: "Semyon", email: "email", token: "1234", role: "user")
        output?.didLoadUserInstance(user: user)
    }

    func addDistanceFilterParameter(parameter: DistanceFilter) {
        switch parameter {
        case .all:
            distanceFilterParameters = ["l_f_p": "1", "l_s_p": "100"]
        case .from1To3:
            distanceFilterParameters = ["l_f_p": "1", "l_s_p": "3"]
        case .from3To6:
            distanceFilterParameters = ["l_f_p": "3", "l_s_p": "6"]
        case .from6To10:
            distanceFilterParameters = ["l_f_p": "6", "l_s_p": "10"]
        }
        distanceFilterParameters?.forEach { key, value in
            filterParameters[key] = value
        }
    }

    func addTimeFilterParameter(parameter: TimeFilter) {
        switch parameter {
        case .all:
            timeFilterParameters = ["t_f_p": "0", "t_s_p": "1000"]
        case .from30mTo60m:
            timeFilterParameters = ["t_f_p": "30", "t_s_p": "60"]
        case .from1hTo2h:
            timeFilterParameters = ["t_f_p": "60", "t_s_p": "120"]
        case .from2hTo3h:
            timeFilterParameters = ["t_f_p": "120", "t_s_p": "180"]
        }
        timeFilterParameters?.forEach { key, value in
            filterParameters[key] = value
        }
    }

    // Загрузка списка экскурсий.
    // Параметры "searchText" и "filterParameters" берутся из свойств класса
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
            with: searchText,
            filterParameters: filterParameters
        )
    }

    func startSearchExcursions(by text: String) {
        search.makeDelayForLoad(for: text)
        output?.showActivity() // Показываю активити когда происходит запрос
    }

    func clearSearchTextQueryParameter() {
        searchText = nil
    }
}

// MARK: ExcursionsSearchHelperOutput

extension ExcursionsListInteractor: ExcursionsSearchHelperOutput {
    func addSearchText(text: String) {
        searchText = text
        loadExcursionsList()
    }
}
