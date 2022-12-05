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
}

// MARK: - ExcursionsListViewInput

protocol ExcursionsListViewInput: AnyObject {
    func reloadView() // Перезагрузка данны в таблице

    func startLoader() // Запустить крутилку с загрузкой

    func stopLoader() // Остановить крутилку с загрузкой

    func showErrorView() // Показать сообщение с ошибкой
}

// MARK: - ErrorViewOutput

protocol ErrorViewOutput: AnyObject {
    func didRepeatButtonPressed()
}
