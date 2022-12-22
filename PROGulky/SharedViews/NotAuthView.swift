//
//  NotAuthView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.12.2022.
//

import UIKit

// MARK: - NotAuthViewDelegate

protocol NotAuthViewDelegate: AnyObject {
    func didCloseButtonTapped()
}

// MARK: - Constants

private struct Constants {
    enum NotAuthView {
        enum Message {
            static let text: String = "Войдите или зарегистрируйтесь"
        }

        enum Button {
            static let marginTop: CGFloat = 20
            static let paddingTop: CGFloat = 8
            static let paddingBottom: CGFloat = 8
            static let paddingLeft: CGFloat = 20
            static let paddingRight: CGFloat = 20
            static let text: String = "Закрыть"
        }
    }
}

// MARK: - NotAuthView

final class NotAuthView: UIView {
    var delegate: NotAuthViewDelegate?

    // Сообщение
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.NotAuthView.Message.text
        return label
    }()

    // Кнопка закрытия вьюхи
    private lazy var closeViewButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        configuration.title = Constants.NotAuthView.Button.text
        configuration.baseBackgroundColor = .prog.Dynamic.primary
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.NotAuthView.Button.paddingTop,
            leading: Constants.NotAuthView.Button.paddingLeft,
            bottom: Constants.NotAuthView.Button.paddingBottom,
            trailing: Constants.NotAuthView.Button.paddingRight
        )
        button.configuration = configuration
        return button
    }()

    @objc func didButtonTapped() {
        delegate?.didCloseButtonTapped()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(messageLabel, closeViewButton)

        configureMessageLabelConstraints()
        configureCloseViewButtonConstraints()
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

    private func configureCloseViewButtonConstraints() {
        closeViewButton.translatesAutoresizingMaskIntoConstraints = false
        closeViewButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeViewButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.NotAuthView.Button.marginTop).isActive = true
    }
}
