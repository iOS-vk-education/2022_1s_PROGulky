//
//  ExcursionsListViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ExcursionsListViewOutput

protocol ExcursionsListViewOutput: AnyObject {
    func didLoadView()

    func item(for index: Int) -> ExcursionViewModel

    func itemsCount() -> Int
}

// MARK: - ExcursionsListViewInput

protocol ExcursionsListViewInput: AnyObject {
}
