//
//  RegistrationVC.swift
//  PROGulky
//
//  Created by Сергей Киселев on 22.11.2022.
//

import UIKit
import SnapKit

final class RegistrationVC: UIViewController, UITextFieldDelegate {
    private let labelTop = UILabel()

    private let firstNameField = CustomTextField(name: TextConstantsSignUp.titleFirstName, image: ImagesAuth.namesImage, security: false)
    private let secondNameField = CustomTextField(name: TextConstantsSignUp.titleSecondName, image: ImagesAuth.namesImage, security: false)
    private let emailField = CustomTextField(name: TextConstantsSignUp.titleEmail, image: ImagesAuth.emailImage, security: false)
    private let passwordField = CustomTextField(name: TextConstantsSignUp.titlePassword, image: ImagesAuth.passwordImage, security: true)
    private let buttonSignUp = CustomButton(title: TextConstantsSignUp.titleSignUp, image: ImagesAuth.LoginBtnImage, color: CustomColor.mainGreen, textColor: CustomColor.whiteColor)
    private let buttonSignIn = CustomButton(title: TextConstantsSignUp.titleSignIn, image: "", color: CustomColor.white, textColor: CustomColor.greyColor)

    private enum Constants {
        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let firstCenterOffset: CGFloat = -200
            static let topOffset: CGFloat = 15
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

        firstNameField.returnKeyType = .next
        secondNameField.returnKeyType = .next
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .done

        firstNameField.delegate = self
        secondNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

        buttonSignIn.addTarget(self, action: #selector(didTapButtonSignIn), for: .touchUpInside)
        buttonSignUp.addTarget(self, action: #selector(didTapButtonSignUp), for: .touchUpInside)

        [labelTop, firstNameField, secondNameField, emailField, passwordField, buttonSignIn, buttonSignUp].forEach {
            view.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            secondNameField.becomeFirstResponder()
        }

        if textField == secondNameField {
            emailField.becomeFirstResponder()
        }

        if textField == emailField {
            passwordField.becomeFirstResponder()
        }

        if buttonSignIn.isUserInteractionEnabled {
            if textField == passwordField {
                didTapButtonSignUp()
            }
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
        let login = LoginVC()
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
            make.height.equalTo(100)
        }

        firstNameField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.TextField.firstCenterOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }

        secondNameField.snp.makeConstraints { make in
            make.top.equalTo(self.firstNameField.snp.bottom).offset(Constants.TextField.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TextField.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TextField.offset)
            make.height.equalTo(Constants.TextField.height)
        }

        emailField.snp.makeConstraints { make in
            make.top.equalTo(self.secondNameField.snp.bottom).offset(Constants.TextField.topOffset)
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
