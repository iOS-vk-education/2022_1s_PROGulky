//
//  ProfileViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit

// MARK: - ProfileViewController

final class ProfileViewController: UIViewController {
    var output: ProfileViewOutput!
    private let titleLabel = UILabel()
    private let userInfoHeader = UserInfoHeader(frame: .zero)
    private let userAccountView = ProfileUserAccountView(frame: .zero)
    private let userAnotherSettingsView = ProfileUserAnotherView(frame: .zero)

    private enum Constants {
        enum Title {
            static let title = "Profile"
            static let topOffset: CGFloat = 6
            static let height: CGFloat = 24
        }

        enum Header {
            static let topOffset: CGFloat = 40
            static let height: CGFloat = 60
        }

        enum Account {
            static let topOffset: CGFloat = 32
            static let height: CGFloat = 158
            static let offset: CGFloat = 20
        }

        enum Other {
            static let topOffset: CGFloat = 32
            static let height: CGFloat = 158
            static let offset: CGFloat = 20
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    func configureUI() {
//        navigationController?.title = Constants.title
        titleLabel.text = Constants.Title.title
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                .offset(Constants.Title.topOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.Title.height)
        }
//        let frameUserInfoHeader = CGRect(x: 20, y: 110, width: view.frame.width, height: 60)
//        userInfoHeader = UserInfoHeader(frame: frameUserInfoHeader)
        view.addSubview(userInfoHeader)
        userInfoHeader.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
                .offset(Constants.Header.topOffset)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.Header.height)
        }

//        let frameUserAccountView = CGRect(x: 20, y: 210, width: view.frame.width - 40, height: 158)
//        userAccountView = ProfileUserAccountView(frame: frameUserAccountView)
        view.addSubview(userAccountView)
        userAccountView.snp.makeConstraints { make in
            make.top.equalTo(self.userInfoHeader.snp.bottom)
                .offset(Constants.Account.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.Account.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Account.offset)
            make.height.equalTo(Constants.Account.height)
        }
        userAccountView.backgroundColor = .white
        userAccountView.layer.shadowColor = UIColor.black.cgColor
        userAccountView.layer.shadowOpacity = 0.1
        userAccountView.layer.shadowOffset = .zero
        userAccountView.layer.shadowRadius = 10
        userAccountView.layer.cornerRadius = 16
        userAccountView.layer.shadowPath = UIBezierPath(rect: userAccountView.bounds).cgPath

//        let frameUserAnotherSettingsView = CGRect(x: 20, y: 400, width: view.frame.width - 40, height: 158)
//        userAnotherSettingsView = ProfileUserAnotherView(frame: frameUserAnotherSettingsView)

        userAnotherSettingsView.backgroundColor = .white
        userAnotherSettingsView.layer.shadowColor = UIColor.black.cgColor
        userAnotherSettingsView.layer.shadowOpacity = 0.1
        userAnotherSettingsView.layer.shadowOffset = .zero
        userAnotherSettingsView.layer.shadowRadius = 10
        userAnotherSettingsView.layer.cornerRadius = 16
        userAnotherSettingsView.layer.shadowPath = UIBezierPath(rect: userAccountView.bounds).cgPath

        view.addSubview(userAnotherSettingsView)
        userAnotherSettingsView.snp.makeConstraints { make in
            make.top.equalTo(self.userAccountView.snp.bottom)
                .offset(Constants.Other.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.Other.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.Other.offset)
            make.height.equalTo(Constants.Other.height)
        }

//        let data = ProfileUserAnotherView.DisplayData(text1: "", text2: "")
        let data = output.getAnotherDisplayData()
        userAnotherSettingsView.configure(data: data)

//        view.addSubview(title)
    }
}

extension ProfileViewController: ProfileViewInput {
}
