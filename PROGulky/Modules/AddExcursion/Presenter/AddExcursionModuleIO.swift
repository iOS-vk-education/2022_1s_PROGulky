//
//  AddExcursionModuleIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - AddExcursionModuleInput

protocol AddExcursionModuleInput: AnyObject {
}

// MARK: - AddExcursionModuleOutput

protocol AddExcursionModuleOutput: AnyObject {
    func addExcursionModuleWantsToOpenAddPlaceModule()
}
