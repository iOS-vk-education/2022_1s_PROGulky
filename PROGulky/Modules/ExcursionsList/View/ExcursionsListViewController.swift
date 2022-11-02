//
//  ExcursionsListViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - ExcursionsListViewController

final class ExcursionsListViewController: UIViewController {
    var output: ExcursionsListViewOutput!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ExcursionsListViewController: ExcursionsListViewInput {
}
