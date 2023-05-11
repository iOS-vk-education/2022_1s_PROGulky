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

    private let image = UIImageView()
    private let registrationLabel = UILabel()

    private let nameField = CustomTextField(
        name: TextConstantsSignUp.titleName,
        security: false
    )

    private let emailField = CustomTextField(
        name: TextConstantsSignUp.titleEmail,
        security: false
    )

    private let passwordField = CustomTextField(
        name: TextConstantsSignUp.titlePassword,
        security: true
    )

    private let passwordSecondField = CustomTextField(
        name: TextConstantsSignUp.titlePasswordSecond,
        security: true
    )

    private var buttonSignUp = CustomButton(
        title: TextConstantsSignUp.titleSignUp,
        color: .prog.Dynamic.primary,
        textColor: .white,
        shadow: true
    )

    private enum Constants {
        enum Image {
            static let height: CGFloat = 200
        }

        enum TextLabel {
            static let topOffset: CGFloat = 15
        }

        enum TextField {
            static let height: CGFloat = 48
            static let topOffset: CGFloat = 15
            static let offset: CGFloat = 20
        }

        enum Button {
            static let topOffset: CGFloat = 30
            static let offset: CGFloat = 20
            static let height: CGFloat = 50
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()

        view.addSubviews(image,
                         registrationLabel,
                         nameField,
                         emailField,
                         passwordField,
                         passwordSecondField,
                         buttonSignUp)

        setupUI()
        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func setupUI() {
        view.backgroundColor = .prog.Dynamic.background
        navigationController?.navigationBar.tintColor = .white

        configureImage()
        configureRegistrationLabel()
        configureNameField()
        configurePasswordField()
        configurePasswordSecondField()
        configureSignUpButton()
    }

    private func configureImage() {
        image.image = UIImage(named: "placeholderImage2")
    }

    private func configureRegistrationLabel() {
        registrationLabel.text = TextConstantsSignUp.titleTop
        registrationLabel.textColor = .prog.Dynamic.primary
        registrationLabel.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.medium)
    }

    private func configureNameField() {
        nameField.returnKeyType = .next
        nameField.delegate = self
    }

    private func configureEmailField() {
        emailField.returnKeyType = .next
        emailField.delegate = self
    }

    private func configurePasswordField() {
        passwordField.returnKeyType = .next
        passwordField.delegate = self
    }

    private func configurePasswordSecondField() {
        passwordSecondField.returnKeyType = .next
        passwordSecondField.delegate = self
    }

    private func configureSignUpButton() {
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)
    }

    private func setupConstraints() {
        setImageConstraints()
        setRegistrationLabelConstraints()
        setNameFieldConstraints()
        setEmailFieldConstraints()
        setPasswordFieldConstraints()
        setPasswordSecondFieldConstraints()
        setSignUpButtonConstraints()
    }

    private func setImageConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(Constants.Image.height)
        }
    }

    private func setRegistrationLabelConstraints() {
        registrationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom).offset(Constants.TextLabel.topOffset)
            make.left.right.equalToSuperview().offset(Constants.TextField.offset)
        }
    }

    private func setNameFieldConstraints() {
        nameField.snp.makeConstraints { make in
            make.top.equalTo(self.registrationLabel.snp.bottom).offset(Constants.TextField.offset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }
    }

    private func setEmailFieldConstraints() {
        emailField.snp.makeConstraints { make in
            make.top.equalTo(self.nameField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }
    }

    private func setPasswordFieldConstraints() {
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(self.emailField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }
    }

    private func setPasswordSecondFieldConstraints() {
        passwordSecondField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }
    }

    private func setSignUpButtonConstraints() {
        buttonSignUp.snp.makeConstraints { make in
            make.top.equalTo(self.passwordSecondField.snp.bottom).offset(Constants.Button.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.Button.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Button.offset)
            make.height.equalTo(Constants.Button.height)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordSecondField.becomeFirstResponder()
        case passwordSecondField:
            didTapButtonSignUp()
        default:
            assertionFailure("error")
        }
        return true
    }

    @objc private func didTapButtonSignUp() {
        guard let email = emailField.text, email != "" else {
            emailField.layer.shadowColor = UIColor.red.cgColor
            return
        }
        guard passwordField.text != "" else {
            passwordField.layer.shadowColor = UIColor.red.cgColor
            return
        }
        guard passwordSecondField.text != "" else {
            passwordSecondField.layer.shadowColor = UIColor.red.cgColor
            return
        }
        guard passwordField.text == passwordSecondField.text else {
            passwordSecondField.layer.shadowColor = UIColor.red.cgColor
            return
        }
        guard let password = passwordField.text else { return }

        let registrationDTO = RegistrationDTO(email: email, password: password, nickname: nameField.text ?? "")
        output?.didTapSignUpButton(registrationDTO: registrationDTO)
    }
}

// MARK: RegistrationViewInput

extension RegistrationViewController: RegistrationViewInput {
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
