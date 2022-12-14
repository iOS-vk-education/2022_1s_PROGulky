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
            static var bottomOffset: CGFloat = -60
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

        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)

        view.addSubviews(labelTop,
                         nameField,
                         emailField,
                         passwordField,
                         passwordSecondField,
                         buttonSignUp)
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

    @objc func didTapButtonSignUp() {
        if emailField.text == "" {
            emailField.layer.borderWidth = 1.0
            emailField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            if passwordField.text == "" {
                passwordField.layer.borderWidth = 1.0
                passwordField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            } else {
                if passwordSecondField.text == "" || passwordField.text != passwordSecondField.text {
                    passwordSecondField.layer.borderWidth = 1.0
                    passwordSecondField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
                } else {
                    emailField.layer.borderWidth = 0
                    passwordField.layer.borderWidth = 0

                    print(emailField.text!)
                    print(passwordField.text!)

                    let registration = RegistrationInteractor().registration(email: emailField.text!, name: nameField.text!, password: passwordField.text!)
                    let token: String?
                    token = registration?.token
                    if token == nil {
                        print("try again")
                        return
                    } else {
                        output.didSelectSignUpBtn(token: token ?? "",
                                                  id: registration?.id ?? 0,
                                                  email: registration?.email ?? "",
                                                  name: registration?.name ?? "",
                                                  role: registration?.role.description ?? "")
                    }
                }
            }
        }
    }

    @objc func didTapRestoreButton() {
        print("forget \n No func yet")
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardHeight // 2
            }
//            view.frame.origin.y -= keyboardHeight
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
    }
}

extension RegistrationViewController: RegistrationViewInput {
}
