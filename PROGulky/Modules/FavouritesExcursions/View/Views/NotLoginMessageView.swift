//
//  NotLoginMessageView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 24.12.2022.
//

import UIKit
import SnapKit

final class NotLoginMessageView: UIView {
    private let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FavouritesExcursionsConstants.MessageView.font
        label.text = "Авторизуйтесь, чтобы увидеть избранное"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(message)

        setupConstraints()
    }

    private func setupConstraints() {
        setMessageConstraints()
    }

    private func setMessageConstraints() {
        message.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
