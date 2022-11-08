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
            static let title = TextConstants.titleProfile
            static let topOffset: CGFloat = 0
            static let height: CGFloat = 24
        }

        enum Header {
            static let topOffset: CGFloat = 20
            static let height: CGFloat = 60
        }

        enum Account {
            static let topOffset: CGFloat = 32
            static let height: CGFloat = 182
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
        view.backgroundColor = CustomColor.whiteColor
        configureUI()
    }

    private func configureUI() {
        titleLabel.text = Constants.Title.title
        titleLabel.textColor = CustomColor.blackColor
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.Title.height)
        }
        view.addSubview(userInfoHeader)
        userInfoHeader.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
                .offset(Constants.Header.topOffset)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.Header.height)
        }
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
        userAccountView.layer.cornerRadius = 16

        userAnotherSettingsView.backgroundColor = .white
        userAnotherSettingsView.layer.cornerRadius = 16

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
