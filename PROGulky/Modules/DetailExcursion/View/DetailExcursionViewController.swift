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
    }
}

extension DetailExcursionViewController: DetailExcursionViewInput {
}
