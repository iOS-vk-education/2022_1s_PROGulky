//
//  BottomSheetHelpersExtensions.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.03.2023.
//

import UIKit

public var pixelSize: CGFloat {
    let scale = UIScreen.mainScreenScale
    return 1.0 / scale
}

public extension CGFloat {
    var pixelCeiled: CGFloat {
        let scale = UIScreen.mainScreenScale
        return Darwin.ceil(self * scale) / scale
    }
}

public extension CGPoint {
    var pixelCeiled: CGPoint {
        CGPoint(x: x.pixelCeiled, y: y.pixelCeiled)
    }
}

public extension CGSize {
    var pixelCeiled: CGSize {
        CGSize(width: width.pixelCeiled, height: height.pixelCeiled)
    }
}

public extension UIScreen {
    static let mainScreenScale = UIScreen.main.scale
    static let mainScreenPixelSize = CGFloat(1.0) / mainScreenScale
}

public extension CGRect {
    // MARK: - Properties

    var center: CGPoint {
        get {
            CGPoint(x: midX, y: midY)
        }
        set {
            origin = CGPoint(x: newValue.x - width * 0.5, y: newValue.y - height * 0.5)
        }
    }

    func isAlmostEqual(to other: CGRect) -> Bool {
        size.isAlmostEqual(to: other.size) && origin.isAlmostEqual(to: other.origin)
    }

    func isAlmostEqual(to other: CGRect, error: CGFloat) -> Bool {
        size.isAlmostEqual(to: other.size, error: error) && origin.isAlmostEqual(to: other.origin, error: error)
    }
}

extension CGSize {
    static func uniform(_ side: CGFloat) -> CGSize {
        CGSize(width: side, height: side)
    }

    // MARK: - Equality

    func isAlmostEqual(to other: CGSize) -> Bool {
        width.isAlmostEqual(to: other.width) && height.isAlmostEqual(to: other.height)
    }

    func isAlmostEqual(to other: CGSize, error: CGFloat) -> Bool {
        width.isAlmostEqual(to: other.width, error: error) && height.isAlmostEqual(to: other.height, error: error)
    }
}

public extension BinaryFloatingPoint {
    func isAlmostEqual(to other: Self) -> Bool {
        abs(self - other) < abs(self + other).ulp
    }

    func isAlmostEqual(to other: Self, accuracy: Self) -> Bool {
        abs(self - other) < (abs(self + other) * accuracy).ulp
    }

    func isAlmostEqual(to other: Self, error: Self) -> Bool {
        abs(self - other) <= error
    }
}

public extension CGPoint {
    // MARK: - Equality

    func isAlmostEqual(to other: CGPoint) -> Bool {
        x.isAlmostEqual(to: other.x) && y.isAlmostEqual(to: other.y)
    }

    func isAlmostEqual(to other: CGPoint, error: CGFloat) -> Bool {
        x.isAlmostEqual(to: other.x, error: error) && y.isAlmostEqual(to: other.y, error: error)
    }
}
