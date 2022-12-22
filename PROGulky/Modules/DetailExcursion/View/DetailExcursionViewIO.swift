//
//  DetailExcursionViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - DetailExcursionViewOutput

protocol DetailExcursionViewOutput: AnyObject {
    func didLoadView()

    func place(for indexPath: IndexPath) -> PlaceViewModel

    func didLikeButtonTapped()

    var placesCount: Int { get }

    var description: String { get }
}

// MARK: - DetailExcursionViewInput

protocol DetailExcursionViewInput: AnyObject {
    func configure(viewModel: DetailExcursionViewModel)

    func configureLikeButton(isLiked: Bool)

    func showAuthView()

    func showErrorView()
}
