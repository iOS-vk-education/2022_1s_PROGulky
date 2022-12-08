//
//  MapViewController.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 21/11/2022.
//

import UIKit
import YandexMapsMobile
import SnapKit

// MARK: - MapViewController

final class MapViewController: UIViewController {
    private var mapView: YMKMapView!
    var output: MapViewOutput!

    private let button = UIButton()
    private let listener: CameraListener = .init()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMaps()
        setupButton()

        output.setupRoute()
    }

    private func setupMaps() {
        mapView = YMKMapView(frame: view.bounds, vulkanPreferred: isM1Simulator())
        mapView.mapWindow.map.mapType = .map
        view.addSubview(mapView)

        listener.delegate = self

        mapView.mapWindow.map.addCameraListener(with: listener)
    }

    private func setupButton() {
        view.addSubview(button)
        view.bringSubviewToFront(button)
        button.setImage(UIImage(named: "compass")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-192)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    private func isM1Simulator() -> Bool {
        (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }

    @objc
    private func buttonTapped(_ sender: UIButton) {
        let currentCameraPosition = mapView.mapWindow.map.cameraPosition
        var cameraPosition: YMKCameraPosition

        cameraPosition = YMKCameraPosition(
            target: currentCameraPosition.target,
            zoom: currentCameraPosition.zoom,
            azimuth: 0,
            tilt: currentCameraPosition.tilt
        )

        mapView.mapWindow.map.move(
            with: cameraPosition,
            animationType: YMKAnimation(type: YMKAnimationType.linear, duration: 0.170)
        )
    }
}

// MARK: MapViewInput

extension MapViewController: MapViewInput {
    func showAlert(with alertMessage: String) {
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    func routeRecieved(route: YMKMasstransitRoute, points: [YMKPoint]) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.addPolyline(with: route.geometry)
        mapObjects.addPlacemarks(with: points,
                                 image: UIImage(named: "search_result")!,
                                 style: YMKIconStyle())

        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: points[0],
                                    zoom: 17,
                                    azimuth: 0,
                                    tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth,
                                        duration: 1)
        )
    }
}

// MARK: ListenerDelegate

extension MapViewController: ListenerDelegate {
    func azimuthChanged(with cameraPosition: YMKCameraPosition) {
        UIView.animate(withDuration: 0.170) {
            self.button.transform = CGAffineTransform(
                rotationAngle: CGFloat(-cameraPosition.azimuth * .pi / 180)
            )
        }
    }
}
