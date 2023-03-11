//
//  CustomViewController.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 10.03.2023.
//

import UIKit
import SnapKit

// Класс для единообразного активити индикатора и вьюх ошибок
class CustomViewController: UIViewController {
    private let activityIndicatorView: UIActivityIndicatorView = .init()
    private let errorHUDView = ErrorHUDView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityIndicator()
        setupErrorHUDView()
    }

    private func setupActivityIndicator() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        view.addSubview(activityIndicatorView)

        activityIndicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }

    private func setupErrorHUDView() {
        errorHUDView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        errorHUDView.isHidden = true
        errorHUDView.alpha = .zero

        view.addSubview(errorHUDView)

        errorHUDView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }

    func showActivity() {
        activityIndicatorView.startAnimating()
    }

    func hideActivity() {
        activityIndicatorView.stopAnimating()
    }

    func showHUD(with error: Error) {
        guard errorHUDView.isHidden else {
            return
        }

        errorHUDView.configure(with: error.localizedDescription)
        errorHUDView.isHidden = false

        view.setNeedsLayout()
        view.layoutIfNeeded()

        animateShowErrorHUDView()
    }

    private func animateShowErrorHUDView() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.errorHUDView.alpha = 0.8
        }) { [weak self] _ in
            self?.animateHideErrorHUDView()
        }
    }

    private func animateHideErrorHUDView() {
        UIView.animate(withDuration: 0.6, delay: 3, animations: { [weak self] in
            self?.errorHUDView.alpha = 0
        }) { [weak self] _ in
            self?.errorHUDView.isHidden = true
        }
    }
}
