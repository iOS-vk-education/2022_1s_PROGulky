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
    private let imageProgramLogo = UIImageView()
    private var nameField = CustomTextField()
    private var emailField = CustomTextField()
    private var passwordField = CustomTextField()
    private var passwordSecondField = CustomTextField()
    private var buttonSignUp = CustomButton(title: TextConstantsSignUp.titleSignUp, image: nil, color: .prog.Dynamic.primary, textColor: .prog.Dynamic.lightText)

    private enum Constants {
        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let firstCenterOffset: CGFloat = -200
            static let topOffset: CGFloat = 15
            static let topLabelHeight: CGFloat = 20
            static let imageLogoSize: CGFloat = 100
            static let bottomOffset: CGFloat = -20
        }

        enum Button {
            static let offset: CGFloat = 20
            static let height: CGFloat = 60
            static var bottomOffset: CGFloat = -60
            static let topOffset: CGFloat = 10
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()

        view.backgroundColor = .prog.Dynamic.background
        imageProgramLogo.image = UIImage(named: "progulkiLabel")
        labelTop.text = TextConstantsSignUp.titleTop
        labelTop.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelTop.textColor = .prog.Dynamic.text

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
        buttonSignUp = CustomButton(title: TextConstantsSignUp.titleSignUp, image: nil, color: .prog.Dynamic.primary, textColor: .prog.Dynamic.lightText)

        nameField.returnKeyType = .next
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .next
        passwordSecondField.returnKeyType = .done

        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        passwordSecondField.delegate = self

        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)

        view.addSubviews(labelTop,
                         nameField,
                         emailField,
                         passwordField,
                         passwordSecondField,
                         buttonSignUp,
                         imageProgramLogo)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
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
            print("error")
        }
        return true
    }

    @objc private func didTapButtonSignUp() {
        guard let email = emailField.text,
              email != "" else {
            emailField.layer.borderWidth = 1.0
            emailField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }
        guard passwordField.text != "" else {
            passwordField.layer.borderWidth = 1.0
            passwordField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }
        guard passwordSecondField.text != "" else {
            passwordSecondField.layer.borderWidth = 1.0
            passwordSecondField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }

        guard passwordField.text == passwordSecondField.text else {
            passwordSecondField.layer.borderWidth = 1.0
            passwordSecondField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }

        guard let password = passwordField.text else { return }

        emailField.layer.borderWidth = 0.5
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordSecondField.layer.borderWidth = 0.5
        passwordSecondField.layer.borderColor = UIColor.lightGray.cgColor

        let registrationDTO = RegistrationDTO(email: email, password: password, nickname: nameField.text ?? "")
        output?.didTapSignUpButton(registrationDTO: registrationDTO)
    }

    private func configureUI() {
        labelTop.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.TextField.offset)
            make.centerX.equalToSuperview()
        }

        imageProgramLogo.snp.makeConstraints { make in
            make.top.equalTo(self.labelTop.snp.bottom).offset(Constants.TextField.offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.TextField.imageLogoSize)
            make.height.equalTo(Constants.TextField.imageLogoSize)
        }
        nameField.snp.makeConstraints { make in
            make.top.equalTo(self.imageProgramLogo.snp.bottom).offset(Constants.TextField.offset)
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
            make.top.equalTo(self.passwordSecondField.snp.bottom).offset(Constants.TextField.offset)
            make.leading.equalToSuperview()
                .offset(Constants.Button.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Button.offset)
            make.height.equalTo(Constants.Button.height)
        }
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
