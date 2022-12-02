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
    var appCoordinator: AppCoordinator?

    private let labelProgramName = UILabel()
    private var emailField = CustomTextField()
    private var passwordField = CustomTextField()
    private var buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn, image: nil, color: .prog.Dynamic.lightPrimary, textColor: .prog.Dynamic.lightText)
    private let buttonSignUp = CustomButton(title: TextConstantsLogin.titleSignUp, image: nil, color: .prog.Dynamic.background, textColor: .prog.Dynamic.text)
    private let buttonRestore = CustomButton(title: TextConstantsLogin.titleRestore, image: nil, color: .prog.Dynamic.background, textColor: .prog.Dynamic.text)
    private enum Constants {
        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let EmailCenterOffset: CGFloat = -120
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

        guard let imageEnvelope = UIImage(systemName: "envelope") else {
            return
        }
        emailField = CustomTextField(name: TextConstantsLogin.titleEmail, image: imageEnvelope, security: false)
        guard let imageLock = UIImage(systemName: "lock") else {
            return
        }
        passwordField = CustomTextField(name: TextConstantsLogin.titlePassword, image: imageLock, security: true)
        guard let imageLogin = UIImage(systemName: "chevron.forward.circle.fill") else {
            return
        }
        buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn, image: imageLogin, color: .prog.Dynamic.lightPrimary, textColor: .prog.Dynamic.lightText)

        labelProgramName.text = TextConstantsLogin.titleProgramName
        labelProgramName.font = UIFont(name: "Arial", size: 50)
        labelProgramName.textColor = .prog.Dynamic.primary

        emailField.returnKeyType = .next
        passwordField.returnKeyType = .done

        emailField.delegate = self
        passwordField.delegate = self

        buttonSignIn.addTarget(self, action: #selector(didTapButtonSignIn), for: .touchUpInside)
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)
        buttonRestore.addTarget(self, action: #selector(didTapRestoreButton), for: .touchUpInside)

        [labelProgramName, emailField, passwordField, buttonSignIn, buttonRestore, buttonSignUp].forEach {
            view.addSubview($0)
        }
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

    @objc func didTapButtonSignIn() {
//        let profile = ProfileViewController()
//        profile.modalPresentationStyle = .fullScreen
//        present(profile, animated: true, completion: nil)

        if emailField.text == "" {
            emailField.layer.borderWidth = 1.0
            emailField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            if passwordField.text == "" {
                passwordField.layer.borderWidth = 1.0
                passwordField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            } else {
                emailField.layer.borderWidth = 0
                passwordField.layer.borderWidth = 0

                print(emailField.text!)
                print(passwordField.text!)

                let login = LoginInteractor().login(email: emailField.text!, password: passwordField.text!)
                let token: Int?
                let refreshToken: String?

                token = login?.id
                if token == nil {
                    print("try again")
                    return
                } else {
//                    let saveAccessToken: Bool = KeychainWrapper.standard.set(token!, forKey: "userToken")
                    print("success!")
                    let profile = ProfileViewController()
                    profile.modalPresentationStyle = .fullScreen
                    present(profile, animated: true, completion: nil)
//                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                }
            }
        }
    }

    @objc func didTapButtonSignUp() {
        let signUp = RegistrationViewController()
        signUp.modalPresentationStyle = .fullScreen
        present(signUp, animated: true, completion: nil)
    }

    @objc func didTapRestoreButton() {
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardHeight
            }
        }
    }

    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }

    private func configureUI() {
        labelProgramName.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.topLabelHeight)
        }

        emailField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.TextField.EmailCenterOffset)
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
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(Constants.Button.bottomOffset)
            make.leading.equalToSuperview()
                .offset(Constants.Button.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Button.offset)
            make.height.equalTo(Constants.Button.height)
        }

        buttonRestore.snp.makeConstraints { make in
            make.top.equalTo(self.passwordField.snp.bottom)
                .offset(Constants.Button.topOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }

        buttonSignUp.snp.makeConstraints { make in
            make.top.equalTo(self.buttonSignIn.snp.bottom)
                .offset(Constants.Button.topOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
    }
}

extension LoginViewController: LoginViewInput {
}
