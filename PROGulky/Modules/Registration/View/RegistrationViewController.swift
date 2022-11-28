//
//  RegistrationViewController.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit
import SnapKit

// MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    var output: RegistrationViewOutput!

    private let labelTop = UILabel()

    private var nameField = CustomTextField()

    private var emailField = CustomTextField()
    private var passwordField = CustomTextField()
    private var passwordSecondField = CustomTextField()
    private var buttonSignUp = CustomButton(title: TextConstantsSignUp.titleSignUp, image: nil, color: .prog.Dynamic.lightPrimary, textColor: .prog.Dynamic.lightText)
    private let buttonSignIn = CustomButton(title: TextConstantsSignUp.titleSignIn, image: nil, color: .prog.Dynamic.background, textColor: .prog.Dynamic.text)

    private enum Constants {
        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let firstCenterOffset: CGFloat = -200
            static let topOffset: CGFloat = 15
            static let topLabelHeight: CGFloat = 100
        }

        enum Button {
            static let offset: CGFloat = 20
            static let height: CGFloat = 60
            static let bottomOffset: CGFloat = -60
            static let topOffset: CGFloat = 10
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        view.backgroundColor = .prog.Dynamic.background

        labelTop.text = TextConstantsSignUp.titleTop
        labelTop.font = UIFont(name: "Arial", size: 50)
        labelTop.textColor = .prog.Dynamic.primary

        guard let imagePerson = UIImage(systemName: "person") else {
            return
        }
        nameField = CustomTextField(name: TextConstantsSignUp.titleName, image: imagePerson, security: false)
        guard let imageEnvelope = UIImage(systemName: "envelope") else {
            return
        }
        emailField = CustomTextField(name: TextConstantsSignUp.titleEmail, image: imageEnvelope, security: false)
        guard let imageLock = UIImage(systemName: "lock") else {
            return
        }
        passwordField = CustomTextField(name: TextConstantsSignUp.titlePassword, image: imageLock, security: true)
        passwordSecondField = CustomTextField(name: TextConstantsSignUp.titlePasswordSecond, image: imageLock, security: true)
        guard let imageLogin = UIImage(systemName: "chevron.forward.circle.fill") else {
            return
        }
        buttonSignUp = CustomButton(title: TextConstantsSignUp.titleSignUp, image: imageLogin, color: .prog.Dynamic.lightPrimary, textColor: .prog.Dynamic.lightText)

        nameField.returnKeyType = .next
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .next
        passwordSecondField.returnKeyType = .done

        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        passwordSecondField.delegate = self

        buttonSignIn.addTarget(self, action: #selector(didTapButtonSignIn), for: .touchUpInside)
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)

        [labelTop, nameField, emailField, passwordField, passwordSecondField, buttonSignIn, buttonSignUp].forEach {
            view.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            emailField.becomeFirstResponder()
        }

        if textField == emailField {
            passwordField.becomeFirstResponder()
        }

        if textField == passwordField {
            passwordSecondField.becomeFirstResponder()
        }

        if textField == passwordSecondField {
            didTapButtonSignUp()
        }

        return true
    }

    @objc func didTapButtonSignUp() {
        let profile = ProfileViewController()
        profile.modalPresentationStyle = .fullScreen
        present(profile, animated: true, completion: nil)
    }

    @objc func didTapButtonSignIn() {
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
    }

    @objc func didTapRestoreButton() {
        print("forget")
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            view.frame.origin.y -= keyboardHeight
        }
    }

    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }

    private func configureUI() {
        labelTop.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.topLabelHeight)
        }

        nameField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.TextField.firstCenterOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }

        emailField.snp.makeConstraints { make in
            make.top.equalTo(self.nameField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }

        passwordField.snp.makeConstraints { make in
            make.top.equalTo(self.emailField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }

        passwordSecondField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }

        buttonSignUp.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(Constants.Button.bottomOffset)
            make.leading.equalToSuperview()
                .offset(Constants.Button.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Button.offset)
            make.height.equalTo(Constants.Button.height)
        }

        buttonSignIn.snp.makeConstraints { make in
            make.top.equalTo(self.buttonSignUp.snp.bottom)
                .offset(Constants.Button.topOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
    }
}

extension RegistrationViewController: RegistrationViewInput {
}
