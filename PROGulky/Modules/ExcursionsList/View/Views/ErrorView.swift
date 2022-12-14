//
//  ErrorView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 05.12.2022.
//

import UIKit

// MARK: - ErrorViewDelegate

protocol ErrorViewDelegate: AnyObject {
    func didRepeatButtonTapped()
}

// MARK: - Constants

private struct Constants {
    enum ErrorView {
        enum Message {
            static let text: String = "Произошла ошибка"
        }

        enum Button {
            static let marginTop: CGFloat = 20
            static let paddingTop: CGFloat = 8
            static let paddingBottom: CGFloat = 8
            static let paddingLeft: CGFloat = 20
            static let paddingRight: CGFloat = 20
            static let text: String = "Повторить"
        }
    }
}

// MARK: - ErrorView

final class ErrorView: UIView {
    var delegate: ErrorViewDelegate?

    // Сообщение
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.ErrorView.Message.text
        return label
    }()

    // Кнопка повтора запроса
    private lazy var repeatRequestButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        configuration.title = Constants.ErrorView.Button.text
        configuration.baseBackgroundColor = .prog.Dynamic.primary
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.ErrorView.Button.paddingTop,
            leading: Constants.ErrorView.Button.paddingLeft,
            bottom: Constants.ErrorView.Button.paddingBottom,
            trailing: Constants.ErrorView.Button.paddingRight
        )
        button.configuration = configuration
        return button
    }()

    @objc func didButtonTapped() {
        delegate?.didRepeatButtonTapped()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(messageLabel, repeatRequestButton)

        configureMessageLabelConstraints()
        configureRepeatRequestButtonConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureMessageLabelConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func configureRepeatRequestButtonConstraints() {
        repeatRequestButton.translatesAutoresizingMaskIntoConstraints = false
        repeatRequestButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        repeatRequestButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.ErrorView.Button.marginTop).isActive = true
    }
}
