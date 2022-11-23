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

    private let nameField = CustomTextField(name: TextConstantsSignUp.titleName, image: ImagesAuth.namesImage, security: false)

    private let emailField = CustomTextField(name: TextConstantsSignUp.titleEmail, image: ImagesAuth.emailImage, security: false)
    private let passwordField = CustomTextField(name: TextConstantsSignUp.titlePassword, image: ImagesAuth.passwordImage, security: true)
    private let passwordSecondField = CustomTextField(name: TextConstantsSignUp.titlePasswordSecond, image: ImagesAuth.passwordImage, security: true)
    private let buttonSignUp = CustomButton(title: TextConstantsSignUp.titleSignUp, image: ImagesAuth.LoginBtnImage, color: CustomColor.mainGreen, textColor: CustomColor.whiteColor)
    private let buttonSignIn = CustomButton(title: TextConstantsSignUp.titleSignIn, image: "", color: CustomColor.white, textColor: CustomColor.greyColor)

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

        view.backgroundColor = CustomColor.white

        labelTop.text = TextConstantsSignUp.titleTop
        labelTop.font = UIFont(name: "Arial", size: 50)
        labelTop.textColor = CustomColor.mainGreen

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
        print("sign up")
        let profile = ProfileViewController()
        profile.modalPresentationStyle = .fullScreen
        present(profile, animated: true, completion: nil)
    }

    @objc func didTapButtonSignIn() {
        print("sign in")
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
    }

    @objc func didTapRestoreButton() {
        print("forget")
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
