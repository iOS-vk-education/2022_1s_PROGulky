//
//  UIView+Extensions.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 08.11.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
