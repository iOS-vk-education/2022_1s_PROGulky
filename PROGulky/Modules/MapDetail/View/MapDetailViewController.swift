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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        output.viewDidLoad()
    }
}

extension MapDetailViewController: MapDetailViewInput {
}

// MARK: MapDetailTransitionHandlerProtocol

extension MapDetailViewController: MapDetailTransitionHandlerProtocol {
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

    func embedDetailModule(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
        detailView = viewController.view
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
//            make.top.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
