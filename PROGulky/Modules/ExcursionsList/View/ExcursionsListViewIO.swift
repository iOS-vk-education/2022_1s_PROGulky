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

    func didSearchButtonTapped()

    func didFilterButtonTapped()

    func textFieldShouldBeginEditing()
}

// MARK: - ExcursionsListViewInput

protocol ExcursionsListViewInput: AnyObject {
    func reloadView() // Перезагрузка данныx в таблице

    func startLoader() // Запустить крутилку с загрузкой

    func stopLoader() // Остановить крутилку с загрузкой

    func showErrorView() // Показать сообщение с ошибкой

    func showAuthView()
    func hideErrorView()

    func configureGreetingMessage(with user: GreetingViewModel) // Конфигурация вьюхи приветствия

    func setSearchButtonToTextField() // В поле поиска показать иконку поиска

    func setFilterButtonToTextField() // В поле поиска показать иконку фильтра

    func hideKeyboard() // Скрытие клавиатуры после нажатия на кнопку поиска
}
