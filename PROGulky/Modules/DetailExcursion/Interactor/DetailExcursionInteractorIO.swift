//
//  DetailExcursionInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - DetailExcursionInteractorOutput

protocol DetailExcursionInteractorOutput: AnyObject {
    func gotAuthError()

    func gotAnotherError()

    func userAddToFavoritesExcursions(for id: Int)

    func userRemoveFromFavoritesExcursions(for id: Int)

    func userChangeStatusLikeButton(on status: Bool)
}

// MARK: - DetailExcursionInteractorInput

protocol DetailExcursionInteractorInput: AnyObject {
    func didLikeButtonTapped(with excursionId: Int, isLiked: Bool)
}
