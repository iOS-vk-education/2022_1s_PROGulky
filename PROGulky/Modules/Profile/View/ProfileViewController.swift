//
//  ProfileViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit

private let reuseIdentifier = "SettingsCell"

// MARK: - ProfileViewController

final class ProfileViewController: UIViewController {
    var output: ProfileViewOutput!
    private let titleLabel = UILabel()
    private let userInfoHeader = UserInfoHeader(frame: .zero)
    private var tableView = UITableView()

    private enum Constants {
        enum Title {
            static let title = TextConstants.titleProfile
            static let topOffset: CGFloat = 0
            static let height: CGFloat = 24
        }

        enum Header {
            static let topOffset: CGFloat = 20
            static let height: CGFloat = 70
        }

        enum TableView {
            static let topOffset: CGFloat = 32
            static let rowHeight: CGFloat = 40
            static let offset: CGFloat = 20
            static let cornerRadius: CGFloat = 16
            static let heightForHeader: CGFloat = 40
            static let height: CGFloat = 390
            static let contentInsetTop: CGFloat = -21
            static let leftAnchor: CGFloat = 16
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.whiteColor
        configureTableView()
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

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.userInfoHeader.snp.bottom)
                .offset(Constants.TableView.topOffset)
            make.leading.equalToSuperview()
                .offset(Constants.TableView.offset)
            make.trailing.equalToSuperview()
                .inset(Constants.TableView.offset)
            make.height.equalTo(Constants.TableView.height)
        }
    }

    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.TableView.rowHeight
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.layer.cornerRadius = Constants.TableView.cornerRadius
        tableView.separatorStyle = .none
        tableView.contentInset.top = Constants.TableView.contentInsetTop
        tableView.alwaysBounceVertical = false
    }

    private func setupTableViewHeader(section: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = CustomColor.mainGreen
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = CustomColor.blackColor
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
                .offset(Constants.TableView.leftAnchor)
        }
        return view
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        SettingsSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }

        switch section {
        case .Account:
            return AccountOptions.allCases.count
        case .Other:
            return OtherOptions.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupTableViewHeader(section: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.TableView.heightForHeader
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingsCell
        cell?.selectionStyle = .none
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .Account:
            let account = AccountOptions(rawValue: indexPath.row)
            cell?.sectionType = account
        case .Other:
            let other = OtherOptions(rawValue: indexPath.row)
            cell?.sectionType = other
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }

        switch section {
        case .Account:
            print(AccountOptions(rawValue: indexPath.row)?.description as Any)
        case .Other:
            print(OtherOptions(rawValue: indexPath.row)?.description as Any)
        }
    }
}
