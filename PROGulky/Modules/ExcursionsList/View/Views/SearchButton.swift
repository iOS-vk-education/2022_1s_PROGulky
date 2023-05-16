//
//  SearchButton.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 04.03.2023.
//

import UIKit
import SnapKit

// MARK: - SearchButtonDelegate

protocol SearchButtonDelegate: AnyObject {
    func didSearchButtonTapped()
}

// MARK: - SearchButton

final class SearchButton: UIButton {
    var delegate: SearchButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSearchButton() {
        setImage(UIImage(systemName: ExcursionsListConstants.SearchButton.icon), for: .normal)
        tintColor = ExcursionsListConstants.SearchButton.color
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        snp.makeConstraints { make in
            make.width.equalTo(ExcursionsListConstants.SearchButton.width)
        }
    }

    @objc private func didButtonTapped() {
        delegate?.didSearchButtonTapped()
    }
}
