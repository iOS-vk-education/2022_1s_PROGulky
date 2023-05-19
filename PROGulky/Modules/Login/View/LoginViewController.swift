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
    private let image = UIImageView()
    private let loginLabel = UILabel()

    private let emailField = CustomTextField(
        name: TextConstantsLogin.titleEmail,
        security: false
    )

    private var passwordField = CustomTextField(
        name: TextConstantsLogin.titlePassword,
        security: true
    )

    private var buttonSignIn = CustomButton(
        title: TextConstantsLogin.titleSignIn,
        color: .prog.Dynamic.primary,
        textColor: .white,
        shadow: true
    )

    private let buttonSignUp = CustomButton(
        title: TextConstantsLogin.titleSignUp,
        color: .prog.Dynamic.background,
        textColor: .prog.Dynamic.primary
    )

    private enum Constants {
        enum Image {
            static let height: CGFloat = 200
        }

        enum TextLabel {
            static let topOffset: CGFloat = 20
        }

        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let EmailCenterOffset: CGFloat = -120
            static let topOffset: CGFloat = 15
            static let imageLogoSize: CGFloat = 100
        }

        enum Button {
            static let offset: CGFloat = 20
            static let height: CGFloat = 50
            static let bottomOffset: CGFloat = -60
            static let topOffset: CGFloat = 30
        }

        enum SignUpButton {
            static let topOffset: CGFloat = 5
        }

        enum Keyboard {
            static let offset: CGFloat = 70
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenterForKeyboardResize()
        hideKeyboardWhenTappedAround()

        view.addSubviews(image,
                         loginLabel,
                         emailField,
                         passwordField,
                         buttonSignIn,
                         buttonSignUp)

        setupUI()
        setupConstraints()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= Constants.Keyboard.offset
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    private func setupNotificationCenterForKeyboardResize() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupUI() {
        view.backgroundColor = .prog.Dynamic.background

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)

        configureImage()
        configureLoginLabel()
        configureEmailField()
        configurePasswordField()
        configureButtonSignIn()
        configureButtonSignUp()
    }

    private func configureImage() {
        image.image = UIImage(named: "placeholderImage2")
    }

    private func configureLoginLabel() {
        loginLabel.text = TextConstantsLogin.titleNavBar
        loginLabel.textColor = .prog.Dynamic.primary
        loginLabel.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.medium)
    }

    private func configureEmailField() {
        emailField.returnKeyType = .next
        emailField.delegate = self
    }

    private func configurePasswordField() {
        passwordField.returnKeyType = .done
        passwordField.delegate = self
    }

    private func configureButtonSignIn() {
        buttonSignIn.setTitleColor(.white, for: .normal)
        buttonSignIn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        buttonSignIn.addTarget(self, action: #selector(didTapButtonSignIn), for: .touchUpInside)
    }

    private func configureButtonSignUp() {
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)
    }

    private func setupConstraints() {
        setImageConstraints()
        setLoginLabelConstraints()
        setEmailFieldConstraints()
        setPasswordFieldConstraints()
        setButtonSignInConstraints()
        setButtonSignUpConstraints()
    }

    private func setImageConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(Constants.Image.height)
        }
    }

    private func setLoginLabelConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom).offset(Constants.TextLabel.topOffset)
            make.left.right.equalToSuperview().offset(Constants.TextField.offset)
        }
    }

    private func setEmailFieldConstraints() {
        emailField.snp.makeConstraints { make in
            make.top.equalTo(self.loginLabel.snp.bottom).offset(Constants.TextField.offset)
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

    private func setButtonSignInConstraints() {
        buttonSignIn.snp.makeConstraints { make in
            make.top.equalTo(self.passwordField.snp.bottom).offset(Constants.Button.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.Button.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Button.offset)
            make.height.equalTo(Constants.Button.height)
        }
    }

    private func setButtonSignUpConstraints() {
        buttonSignUp.snp.makeConstraints { make in
            make.top.equalTo(self.buttonSignIn.snp.bottom)
                .offset(Constants.SignUpButton.topOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        guard let email = emailField.text, email != "" else {
            emailField.layer.shadowColor = UIColor.red.cgColor
            return
        }
        guard let password = passwordField.text, password != "" else {
            passwordField.layer.shadowColor = UIColor.red.cgColor
            return
        }

        let login = LoginDTO(email: email, password: password)
        output?.didTapSignInButton(loginDTO: login)
    }

    @objc private func didTapButtonSignUp() {
        output?.didSelectSignUpBtn()
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
