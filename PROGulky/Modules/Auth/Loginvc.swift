//
//  Loginvc.swift
//  PROGulky
//
//  Created by Сергей Киселев on 21.11.2022.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController, UITextFieldDelegate {
    private let labelProgramName = UILabel()

    private let emailField = CustomTextField(name: TextConstantsLogin.titleEmail, image: ImagesAuth.emailImage, security: false)
    private let passwordField = CustomTextField(name: TextConstantsLogin.titlePassword, image: ImagesAuth.passwordImage, security: true)
    private let buttonSignIn = CustomButton(title: TextConstantsLogin.titleSignIn, image: ImagesAuth.LoginBtnImage, color: CustomColor.mainGreen, textColor: CustomColor.whiteColor)
    private let buttonSignUp = CustomButton(title: TextConstantsLogin.titleSignUp, image: "", color: CustomColor.white, textColor: CustomColor.greyColor)
    private let buttonRestore = CustomButton(title: TextConstantsLogin.titleRestore, image: "", color: CustomColor.white, textColor: CustomColor.greyColor)

    private enum Constants {
        enum TextField {
            static let offset: CGFloat = 20
            static let height: CGFloat = 48
            static let EmailCenterOffset: CGFloat = -120
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

        labelProgramName.text = TextConstantsLogin.titleProgramName
        labelProgramName.font = UIFont(name: "Arial", size: 50)
        labelProgramName.textColor = CustomColor.mainGreen

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
        print("sign in")
        let profile = ProfileViewController()
        profile.modalPresentationStyle = .fullScreen
        present(profile, animated: true, completion: nil)
    }

    @objc func didTapButtonSignUp() {
        print("sign up")
        let signUp = RegistrationVC()
        signUp.modalPresentationStyle = .fullScreen
        present(signUp, animated: true, completion: nil)
    }

    @objc func didTapRestoreButton() {
        print("forget")
    }

    private func configureUI() {
        labelProgramName.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
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
