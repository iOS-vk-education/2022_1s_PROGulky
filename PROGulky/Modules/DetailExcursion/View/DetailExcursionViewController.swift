//
//  DetailExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - DetailExcursionViewController

final class DetailExcursionViewController: UIViewController {
    var output: DetailExcursionViewOutput!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavBar()
    }

    private func setupNavBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(named: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapBackButton))

        navigationItem.leftBarButtonItem = backButtonItem
        // navigationController?.navigationBar.tintColor = .red
    }

    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
}

extension DetailExcursionViewController: DetailExcursionViewInput {
}
