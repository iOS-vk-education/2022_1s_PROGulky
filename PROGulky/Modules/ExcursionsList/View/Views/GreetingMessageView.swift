//
//  GreetingMessage.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 03.03.2023.
//

import UIKit

final class GreetingMessageView: UIView {
    // Приветственное слово
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = ExcursionsListConstants.GreetingMessage.labelColor
        label.font = UIFont.systemFont(ofSize: ExcursionsListConstants.GreetingMessage.labelFontSize, weight: .bold)
        return label
    }()

    // Кнопка входа в профиль или редирект на вход
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(ExcursionsListConstants.GreetingMessage.buttonColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: ExcursionsListConstants.GreetingMessage.buttonFontSize, weight: .bold)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(label, button)

        configureLabelConstraints()
        configureButtonConstraints()
    }

    func set(viewModel: GreetingViewModel) {
        label.text = viewModel.labelText
        button.setTitle(viewModel.buttonText, for: .normal)
    }

    private func configureLabelConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
    }

    private func configureButtonConstraints() {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(label.snp.right).offset(ExcursionsListConstants.GreetingMessage.offset)
            make.width.equalTo(200)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
