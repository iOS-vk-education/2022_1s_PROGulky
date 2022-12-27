//
//  FavouritesExcursionsModuleIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - FavouritesExcursionsModuleInput

protocol FavouritesExcursionsModuleInput: AnyObject {
}

// MARK: - FavouritesExcursionsModuleOutput

protocol FavouritesExcursionsModuleOutput: AnyObject {
    func favoritesExcursionsListModuleWantsToOpenMapDetailModule(excursion: Excursion)
}
