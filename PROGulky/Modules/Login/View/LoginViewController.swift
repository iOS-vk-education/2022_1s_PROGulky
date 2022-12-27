//
//  LoginViewController.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit
import SnapKit

// MARK: - LoginViewController

final class LoginViewController: UIViewController, UITextFieldDelegate {
    var output: LoginViewOutput!
    private let imageProgramLogo = UIImageView()
    private var emailField = CustomTextField()
    private var passwordField = CustomTextField()
    private var buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn, image: nil, color: .prog.Dynamic.primary, textColor: .prog.Dynamic.lightText)
    private let buttonSignUp = CustomButton(title: TextConstantsLogin.titleSignUp, image: nil, color: .prog.Dynamic.background, textColor: .prog.Dynamic.text)
    private enum Constants {
        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let EmailCenterOffset: CGFloat = -120
            static let topOffset: CGFloat = 15
            static let imageLogoSize: CGFloat = 100
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

        view.backgroundColor = .prog.Dynamic.background

        guard let imageEnvelope = UIImage(systemName: "envelope") else {
            return
        }
        emailField = CustomTextField(name: TextConstantsLogin.titleEmail, image: imageEnvelope, security: false)
        guard let imageLock = UIImage(systemName: "lock") else {
            return
        }
        passwordField = CustomTextField(name: TextConstantsLogin.titlePassword, image: imageLock, security: true)
        buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn, image: nil, color: .prog.Dynamic.primary, textColor: .prog.Dynamic.lightText)

        navigationItem.title = TextConstantsLogin.titleNavBar

        imageProgramLogo.image = UIImage(named: "progulkiLabel")
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .done

        emailField.delegate = self
        passwordField.delegate = self

        buttonSignIn.addTarget(self, action: #selector(didTapButtonSignIn), for: .touchUpInside)
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)

        view.addSubviews(imageProgramLogo,
                         emailField,
                         passwordField,
                         buttonSignIn,
                         buttonSignUp)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }

        if buttonSignIn.isUserInteractionEnabled {
            if textField == passwordField {
                didTapButtonSignIn()
            }
        }

        return true
    }

    @objc private func didTapButtonSignIn() {
        guard let email = emailField.text,
              email != "" else {
            emailField.layer.borderWidth = 1.0
            emailField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }
        guard let password = passwordField.text,
              password != "" else {
            passwordField.layer.borderWidth = 1.0
            passwordField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }
        emailField.layer.borderWidth = 0.5
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.borderColor = UIColor.lightGray.cgColor

        let login = LoginDTO(email: email, password: password)
        output?.didTapSignInButton(loginDTO: login)
    }

    @objc private func didTapButtonSignUp() {
        output?.didSelectSignUpBtn()
    }

    private func configureUI() {
        imageProgramLogo.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.TextField.topOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.TextField.imageLogoSize)
            make.height.equalTo(Constants.TextField.imageLogoSize)
        }

        emailField.snp.makeConstraints { make in
            make.top.equalTo(self.imageProgramLogo.snp.bottom).offset(Constants.TextField.offset)
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

        buttonSignIn.snp.makeConstraints { make in
            make.top.equalTo(self.passwordField.snp.bottom).offset(Constants.Button.offset)
            make.leading.equalToSuperview()
                .offset(Constants.Button.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Button.offset)
            make.height.equalTo(Constants.Button.height)
        }

        buttonSignUp.snp.makeConstraints { make in
            make.top.equalTo(self.buttonSignIn.snp.bottom)
                .offset(Constants.Button.offset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
    }
}

// MARK: LoginViewInput

extension LoginViewController: LoginViewInput {
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
