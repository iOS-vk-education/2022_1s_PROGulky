//
//  CustomButton.swift
//  PROGulky
//
//  Created by Сергей Киселев on 21.11.2022.
//

import UIKit

class CustomButton: UIButton {
    init(title: String, image: String, color: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        layer.cornerRadius = 20
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = UIImage(named: image)
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.baseBackgroundColor = color
        config.baseForegroundColor = textColor
        config.background.cornerRadius = 99
        config.cornerStyle = .fixed

        configuration = config
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
