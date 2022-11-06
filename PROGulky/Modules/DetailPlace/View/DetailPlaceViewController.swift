//
//  DetailPlaceViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - DetailPlaceViewController

final class DetailPlaceViewController: UIViewController {
    var output: DetailPlaceViewOutput!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailPlaceViewController: DetailPlaceViewInput {
}
