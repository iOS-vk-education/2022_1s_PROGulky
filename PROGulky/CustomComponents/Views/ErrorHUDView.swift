//
//  ErrorHUDView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 11.03.2023.
//

import UIKit
import SnapKit

// MARK: - Constants

private struct Constants {
    enum ErrorHUDView {
        enum View {
            static let cornerRadius: CGFloat = 8
            static let backgroundColor: UIColor = .systemGray6
            static let inset: CGFloat = 15
        }

        enum Label {
            static let inset: CGFloat = 15
            static let textColor: UIColor = UIColor.prog.Dynamic.text
            static let numberOfLines = 3
        }
    }
}

// MARK: - ErrorHUDView

final class ErrorHUDView: UIView {
    private let containerView: UIView = .init()
    private let errorHUDLabel: UILabel = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubviews(containerView, errorHUDLabel)

        setupContainerView()
        setupLabel()
    }

    func configure(with text: String) {
        errorHUDLabel.text = text
    }

    // MARK: - Setup Styles

    private func setupContainerView() {
        containerView.layer.cornerRadius = Constants.ErrorHUDView.View.cornerRadius
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = Constants.ErrorHUDView.View.backgroundColor

        setupContainerViewConstraints()
    }

    private func setupLabel() {
        errorHUDLabel.textColor = Constants.ErrorHUDView.Label.textColor
        errorHUDLabel.textAlignment = .center
        errorHUDLabel.numberOfLines = Constants.ErrorHUDView.Label.numberOfLines

        setupLabelConstraints()
    }

    // MARK: - Setup constraints

    private func setupContainerViewConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ErrorHUDView.View.inset)
        }
    }

    private func setupLabelConstraints() {
        errorHUDLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView.snp.left).inset(Constants.ErrorHUDView.Label.inset)
            make.right.equalTo(containerView.snp.right).inset(Constants.ErrorHUDView.Label.inset)
            make.top.equalTo(containerView.snp.top).inset(Constants.ErrorHUDView.Label.inset)
            make.bottom.equalTo(containerView.snp.bottom).inset(Constants.ErrorHUDView.Label.inset)
        }
    }
}
