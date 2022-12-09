//
//  MapDetailViewController.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

import UIKit

// MARK: - MapDetailViewController

final class MapDetailViewController: UIViewController {
    var output: MapDetailViewOutput!
    private var mapView: UIView!

    private enum Constants {
        static let backButtonImageName = "chevron.left"
        static let smallSheetHeight: CGFloat = 190
        static let cornerRadius: CGFloat = 13
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .prog.Dynamic.background
        setupNavigationBar()
        output.viewDidLoad()
    }

    private func setupNavigationBar() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        let backButtonItem = UIBarButtonItem()
        backButtonItem.tintColor = .black
        backButtonItem.title = nil
        backButtonItem.style = .plain
        backButtonItem.target = self
        backButtonItem.action = #selector(backButtonTapped)
        backButtonItem.image = UIImage(systemName: Constants.backButtonImageName)
        navigationItem.leftBarButtonItem = backButtonItem
    }

    @objc
    private func backButtonTapped() {
        dismiss(animated: false)
        output.backButtonTapped()
    }
}

extension MapDetailViewController: MapDetailViewInput {
}

// MARK: MapDetailTransitionHandlerProtocol

extension MapDetailViewController: MapDetailTransitionHandlerProtocol {
    func embedDetailModule(_ viewController: UIViewController) {
        guard let detailViewController = viewController as? DetailExcursionViewController else { return }
        detailViewController.viewDidLoad()

        detailViewController.isModalInPresentation = true
        if let sheet = detailViewController.sheetPresentationController {
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: .medium) { _ in
                Constants.smallSheetHeight
            }

            sheet.detents = [smallDetent, .large()]
            sheet.preferredCornerRadius = Constants.cornerRadius
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
        }
        present(detailViewController, animated: true)
    }

    func embedMapModule(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
        mapView = viewController.view
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
