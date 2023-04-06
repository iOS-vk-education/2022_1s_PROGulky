//
//  ExcursionsListViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ExcursionsListViewOutput

protocol ExcursionsListViewOutput: AnyObject {
    func didLoadView()

    func item(for index: Int) -> ExcursionViewModel

    func itemsCount() -> Int

    func didSelectCell(at indexPath: IndexPath)

    func didRepeatButtonTapped()

    func didAddExcursionButtonTapped()

    func didTextTyping(with text: String)

    func didClearSearchBar()

    // Методы фильра
    func getDistanceFilterButtons() -> [FilterButtonViewModel] // Получить параметры фильтра "Длина маршрута"

    func didDistanceFilterButtonTapped(with title: String) // Нажата кнопка фильтра "Длина маршрута" (в нее передано название нажатой кнопки)

    func didFilterSubmitButtonTapped() // Нажали на кнопку "Применить" в фильтре
}

// MARK: - ExcursionsListFiltersViewOutput

protocol ExcursionsListFiltersViewOutput: AnyObject {
    func getDistanceFilterButtons() -> [FilterButtonViewModel]

    func didDistanceFilterButtonTapped(with title: String)

    func didSubmitButtonTapped()
}

// MARK: - ExcursionsListViewInput

protocol ExcursionsListViewInput: AnyObject {
    func reloadView() // Перезагрузка данныx в таблице

    func startLoader() // Запустить крутилку с загрузкой

    func stopLoader() // Остановить крутилку с загрузкой

    func showErrorView(with error: Error) // Показать сообщение с ошибкой

    func showAuthView()

    func hideErrorView()

    func configureGreetingMessage(with user: GreetingViewModel) // Конфигурация вьюхи приветствия
}
