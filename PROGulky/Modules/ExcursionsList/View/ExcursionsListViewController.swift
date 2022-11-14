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

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .red
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Экскурсии"
//            excursions = fetchData()
//            configureTableView()
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))

        navigationItem.rightBarButtonItem = rightBarButtonItem
//        title = "Экскурсии"
    }

    @objc func didTapAddButton() {
    }
}

extension ExcursionsListViewController: ExcursionsListViewInput {
}
