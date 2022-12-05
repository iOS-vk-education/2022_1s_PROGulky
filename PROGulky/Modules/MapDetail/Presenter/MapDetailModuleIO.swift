//
//  MapDetailModuleIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

// MARK: - MapDetailModuleInput

protocol MapDetailModuleInput: AnyObject {
}

// MARK: - MapDetailModuleOutput

protocol MapDetailModuleOutput: AnyObject {
    func mapDetailModuleWantsToClose()
    func mapDetailModuleWantsToOpenDetailModule(excursion: Excursion)
}
