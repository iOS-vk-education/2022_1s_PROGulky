//
//  ExcursionsListViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ExcursionsListViewOutput

protocol ExcursionsListViewOutput: AnyObject {
    func getExcursionsListDisplayData() -> [Excursion]
}

// MARK: - ExcursionsListViewInput

protocol ExcursionsListViewInput: AnyObject {
}
