//
//  ExcursionsListInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ExcursionsListInteractorOutput

protocol ExcursionsListInteractorOutput: AnyObject {
    func didLoadExcursionsList(excursions: Excursions)
}

// MARK: - ExcursionsListInteractorInput

protocol ExcursionsListInteractorInput: AnyObject {
    func loadExcursionsList()
}
