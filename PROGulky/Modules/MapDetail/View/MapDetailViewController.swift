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
    var mapView: UIView!
    var detailView: UIView!

    private var panGestureRecognizer: UIPanGestureRecognizer?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .prog.Dynamic.background
        setupNavigationBar()
        setupGestureRecognizer()
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
        backButtonItem.image = UIImage(systemName: "chevron.left")
        navigationItem.leftBarButtonItem = backButtonItem
    }

    private func setupDetailView() {
//        detailView.set(excursion: output.viewModel)
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        detailView.isUserInteractionEnabled = true
    }

    private func setupGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        panGestureRecognizer?.minimumNumberOfTouches = 1
    }

    @objc
    private func backButtonTapped() {
        output.backButtonTapped()
    }

    @objc
    private func handleSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {        
        output.handleSwipe()
    }
}

extension MapDetailViewController: MapDetailViewInput {
}

// MARK: MapDetailTransitionHandlerProtocol

extension MapDetailViewController: MapDetailTransitionHandlerProtocol {
    func embedDetailModule(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
        guard let detailViewController = viewController as? DetailExcursionViewController else { return }
        detailViewController.viewDidLoad()
        detailViewController.detailExcursionInfoView.makeBottomSheetView(isBottomSheet: true)
        detailView = detailViewController.detailExcursionInfoView
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        detailView.isUserInteractionEnabled = true
        detailView.addGestureRecognizer(panGestureRecognizer!)
    }

    func embedMapModule(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
        mapView = viewController.view
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(detailView.snp.top)
        }
    }
}
