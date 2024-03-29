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
        output.didLoadView()
    }

    private func setupNavigationBar() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        let backButtonItem = UIBarButtonItem()
        backButtonItem.tintColor = .black
        backButtonItem.title = nil
        backButtonItem.style = .plain
        backButtonItem.target = self
        backButtonItem.action = #selector(didTapBackButton)
        backButtonItem.image = UIImage(systemName: Constants.backButtonImageName)
        navigationItem.leftBarButtonItem = backButtonItem
    }

    @objc
    private func didTapBackButton() {
        dismiss(animated: false)
        output.didTapBackButton()
    }
}

extension MapDetailViewController: MapDetailViewInput {
}

// MARK: MapDetailTransitionHandlerProtocol

extension MapDetailViewController: MapDetailTransitionHandlerProtocol {
    func embedDetailModule(_ viewController: UIViewController) {
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
