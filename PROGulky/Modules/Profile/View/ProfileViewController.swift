//
//  ProfileViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit
import MessageUI

private let reuseIdentifier = "SettingsCell"

// MARK: - ProfileViewController

final class ProfileViewController: UIViewController {
    var output: ProfileViewOutput!
    private let userInfoHeader = UserInfoHeader(frame: .zero)
    private var tableView = UITableView()

    private enum Constants {
        enum Header {
            static let topOffset: CGFloat = 20
            static let height: CGFloat = 100
        }

        enum TableView {
            static let topOffset: CGFloat = 32
            static let rowHeight: CGFloat = 40
            static let offset: CGFloat = 0
            static let cornerRadius: CGFloat = 16
            static let heightForHeader: CGFloat = 40
            static let height: CGFloat = 420
            static let contentInsetTop: CGFloat = 0
            static let leftAnchor: CGFloat = 16
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .prog.Dynamic.background
        configureTableView()
        configureUI()
        userInfoHeader.configure(output.headerDisplayData)
    }

    private func configureUI() {
        navigationItem.title = TextConstantsProfile.titleProfile
        view.addSubview(userInfoHeader)
        userInfoHeader.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
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
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.TableView.rowHeight
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .prog.Dynamic.background
        tableView.separatorStyle = .none
        tableView.contentInset.top = Constants.TableView.contentInsetTop
        tableView.alwaysBounceVertical = false
    }

    private func setupTableViewHeader(section: Int) -> UIView {
        let view = UIView()
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .prog.Dynamic.textGray
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

// MARK: ProfileViewInput

extension ProfileViewController: ProfileViewInput {
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
            switch AccountOptions(rawValue: indexPath.row)!.rawValue {
            case 0:
                present(PlugViewController(), animated: true) // Заглушка
                print(TextConstantsProfile.titlePersonalData)
            case 1:
                present(PlugViewController(), animated: true) // Заглушка
                print(TextConstantsProfile.titleAchievements)
            case 2:
                present(PlugViewController(), animated: true) // Заглушка
                print(TextConstantsProfile.titleHistory)
            case 3:
                showMailComposer(message: TextConstantsProfile.beGuideMessage)
            default:
                print("no action")
            }
        case .Other:
            switch OtherOptions(rawValue: indexPath.row)!.rawValue {
            case 0:
                showMailComposer(message: TextConstantsProfile.contactUsMessageTitle)
            case 1:
                if let url = URL(string: "https://pages.flycricket.io/progulki/privacy.html") {
                    UIApplication.shared.open(url)
                }
            case 2:
                let alert = UIAlertController(title: "Вы уверены, что хотите выйти?", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: { action in
                    self.goToLogin()
                }))
                alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
                    alert.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)

            default:
                print("no action")
            }
        }
    }

    func goToLogin() {
        output.logoutButtonTapped()
    }

    func showMailComposer(message: String) {
        guard MFMailComposeViewController.canSendMail() else {
            print("can't send")
            return
        }

        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([TextConstantsProfile.contactUsMail])
        composer.setSubject(message)

        present(composer, animated: true)
    }
}

// MARK: MFMailComposeViewControllerDelegate

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        @unknown default:
            break
        }

        controller.dismiss(animated: true)
    }
}
