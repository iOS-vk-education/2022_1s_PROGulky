//
//  FilterButton.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 02.03.2023.
//

import UIKit

// MARK: - FilterButtonDelegate

protocol FilterButtonDelegate: AnyObject {
    func didFiterButtonTapped()
}

// MARK: - FilterButton

final class FilterButton: UIButton {
    var delegate: FilterButtonDelegate?

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
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)

        snp.makeConstraints { make in
            make.width.equalTo(ExcursionsListConstants.FilterButton.width)
        }
    }

    @objc private func didButtonTapped() {
        delegate?.didFiterButtonTapped()
    }
}
