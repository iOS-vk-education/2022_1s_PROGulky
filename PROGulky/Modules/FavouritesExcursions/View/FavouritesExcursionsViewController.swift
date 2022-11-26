//
//  FavouritesExcursionsViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit

// MARK: - FavouritesExcursionsViewController

final class FavouritesExcursionsViewController: UIViewController {
    var output: FavouritesExcursionsViewOutput!

    private let message = FavouritesExcursionsMessageView(frame: .zero)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = FavouritesExcursionsConstants.Screen.backgroundColor
        setupNavBar()
        setupMessageView()
    }

    // Настройка нав бара
    private func setupNavBar() {
        navigationItem.title = FavouritesExcursionsConstants.NavBar.title
    }

    private func setupMessageView() {
        view.addSubview(message)
    }

    private func setupConstraints() {
        setupMessageViewConstraints()
    }

    private func setupMessageViewConstraints() {
        message.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension FavouritesExcursionsViewController: FavouritesExcursionsViewInput {
}
