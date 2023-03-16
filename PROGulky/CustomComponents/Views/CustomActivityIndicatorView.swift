//
//  CustomActivityIndicatorView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.03.2023.
//

import UIKit
import SnapKit

// MARK: - Constants

private struct Constants {
    enum CustomActivityIndicatorView {
        enum View {
            static let cornerRadius: CGFloat = 8
            static let backgroundColor: UIColor = .systemGray6
        }

        enum ActivityIndicator {
            static let inset: CGFloat = 20
        }
    }
}

// MARK: - CustomActivityIndicatorView

final class CustomActivityIndicatorView: UIView {
    private let containerView: UIView = .init()
    private let activityIndicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubviews(containerView, activityIndicator)

        setupContainerView()
        setupActivityIndicator()
    }

    // MARK: - Setup Styles

    private func setupContainerView() {
        containerView.layer.cornerRadius = Constants.CustomActivityIndicatorView.View.cornerRadius
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = Constants.CustomActivityIndicatorView.View.backgroundColor

        setupContainerViewConstraints()
    }

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true

        setupActivityIndicatorConstraints()
    }

    // MARK: - Setup constraints

    private func setupContainerViewConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    private func setupActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.left.equalTo(containerView.snp.left).inset(Constants.CustomActivityIndicatorView.ActivityIndicator.inset)
            make.right.equalTo(containerView.snp.right).inset(Constants.CustomActivityIndicatorView.ActivityIndicator.inset)
            make.top.equalTo(containerView.snp.top).inset(Constants.CustomActivityIndicatorView.ActivityIndicator.inset)
            make.bottom.equalTo(containerView.snp.bottom).inset(Constants.CustomActivityIndicatorView.ActivityIndicator.inset)
        }
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
