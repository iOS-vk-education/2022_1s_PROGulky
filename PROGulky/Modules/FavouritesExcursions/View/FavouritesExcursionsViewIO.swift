//
//  FavouritesExcursionsViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - FavouritesExcursionsViewOutput

protocol FavouritesExcursionsViewOutput: AnyObject {
    func didLoadView()

    func item(for index: Int) -> ExcursionViewModel

    func itemsCount() -> Int

    func didSelectCell(at indexPath: IndexPath)

    func didRepeatButtonTapped()

    func didPullResfresh()
}

// MARK: - FavouritesExcursionsViewInput

protocol FavouritesExcursionsViewInput: AnyObject {
    func showNotAuthView() // Вью, если на экран заходит не авторизовнный

    func showEmptyListView() // Вью, если список избранных пуст

    func showErrorView() // Вью, если интерактор вернул ошибку

    func startLoader() // Запустить крутилку

    func stopLoader() // Остановить крутилку

    func reloadView() // Перезагрузить таблицу

    func hideEmptyListView() // Спрятать надпись о пустом избранном
}
