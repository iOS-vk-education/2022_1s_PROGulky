//
//  ExcursionsListModuleIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ExcursionsListModuleInput

protocol ExcursionsListModuleInput: AnyObject {
}

// MARK: - ExcursionsListModuleOutput

protocol ExcursionsListModuleOutput: AnyObject {
    func excursionsListModuleWantsToOpenDetailModule(excursionId: Int)

    func excursionsListModuleWantsToOpenAddExcursion()
}
