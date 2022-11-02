//
//  FavouritesExcursionsViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - FavouritesExcursionsViewController

final class FavouritesExcursionsViewController: UIViewController {
    var output: FavouritesExcursionsViewOutput!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

extension FavouritesExcursionsViewController: FavouritesExcursionsViewInput {
}
