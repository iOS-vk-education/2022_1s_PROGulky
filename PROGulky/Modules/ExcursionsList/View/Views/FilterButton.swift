//
//  FilterButton.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 02.03.2023.
//

import UIKit

final class FilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFilterButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFilterButton() {
        setImage(UIImage(systemName: ExcursionsListConstants.FilterButton.icon), for: .normal)
        tintColor = ExcursionsListConstants.FilterButton.color
        widthAnchor.constraint(equalToConstant: ExcursionsListConstants.FilterButton.width).isActive = true
    }
}
