//
//  CameraListener.swift
//  PROGulky
//
//  Created by Иван Тазенков on 22.11.2022.
//

import Foundation
import YandexMapsMobile

// MARK: - ListenerDelegate

protocol ListenerDelegate: AnyObject {
    func azimuthChanged(with cameraPosition: YMKCameraPosition)
}

// MARK: - CameraListener

class CameraListener: NSObject, YMKMapCameraListener {
    var delegate: ListenerDelegate?

    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        delegate?.azimuthChanged(with: cameraPosition)
    }
}
