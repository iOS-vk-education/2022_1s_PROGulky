//
//  LoginViewController.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit
import SnapKit

// MARK: - LoginViewController

final class LoginViewController: UIViewController {
    var output: LoginViewOutput!
    private let imageProgramLogo = UIImageView()
    private var emailField = CustomTextField()
    private var passwordField = CustomTextField()
    private var buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn,
                                            image: nil,
                                            color: .prog.Dynamic.primary,
                                            textColor: .prog.Dynamic.lightText)

    private let buttonSignUp = CustomButton(title: TextConstantsLogin.titleSignUp,
                                            image: nil,
                                            color: .prog.Dynamic.background,
                                            textColor: .prog.Dynamic.text)
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

        enum Image {
            static let email = "envelope"
            static let password = "lock"
            static let logo = "progulkiLabel"
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupViews() {
        hideKeyboardWhenTappedAround()

        view.backgroundColor = .prog.Dynamic.background

        buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn, image: nil, color: .prog.Dynamic.primary, textColor: .prog.Dynamic.lightText)

        navigationItem.title = TextConstantsLogin.titleNavBar

        imageProgramLogo.image = UIImage(named: Constants.Image.logo)

        buttonSignIn.addTarget(self, action: #selector(didTapButtonSignIn), for: .touchUpInside)
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)
        setupTextFields()
        view.addSubviews(imageProgramLogo,
                         buttonSignIn,
                         buttonSignUp)
    }

    private func setupTextFields() {
        guard let imageEnvelope = UIImage(systemName: Constants.Image.email) else {
            return
        }
        emailField = CustomTextField(name: TextConstantsLogin.titleEmail, image: imageEnvelope, security: false)
        guard let imageLock = UIImage(systemName: Constants.Image.password) else {
            return
        }
        passwordField = CustomTextField(name: TextConstantsLogin.titlePassword, image: imageLock, security: true)
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .done

        emailField.delegate = self
        passwordField.delegate = self
        view.addSubviews(emailField,
                         passwordField)
    }

    @objc private func didTapButtonSignIn() {
        guard validateTextFields(textFields: emailField, passwordField),
              let email = emailField.text,
              let password = passwordField.text
        else { return }

        emailField.layer.borderWidth = 0.5
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.borderColor = UIColor.lightGray.cgColor

        let login = LoginDTO(email: email, password: password)
        output?.didTapSignInButton(loginDTO: login)
    }

    private func validateTextFields(textFields: UITextField...) -> Bool {
        var flag = true
        for field in textFields {
            if let text = field.text,
               text.isEmpty {
                flag = false
                field.layer.borderWidth = 1.0
                field.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            } else {
                field.layer.borderWidth = 0.5
                field.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        return flag
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
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
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
}
