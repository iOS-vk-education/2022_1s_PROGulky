//
//  ExcursionsListViewController.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 31/10/2022.
//

import UIKit
import SnapKit

// MARK: - ExcursionsListViewController

final class ExcursionsListViewController: UIViewController {
    var output: ExcursionsListViewOutput!

    private let greetingMessageView = GreetingMessageView(frame: .zero, name: "Semyon")
    private let searchTextField = SearchTextField(placeholder: "Поиск экскурсий")
    private let filterButton = FilterButton()
    private var excursionsTable = UITableView(frame: .zero, style: .plain)
    private let loader = UIActivityIndicatorView(frame: .zero)
    private let errorView = ErrorView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        output.didLoadView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didLoadView()
    }

    private func setupUI() {
        setupNavBar()
        setupGreetingMessageView()
        setupSearchTextField()
        setupTableView()
        setupLoader()
        setupErrorView()
    }

    func reload() {
        excursionsTable.reloadData()
    }

    private func setupGreetingMessageView() {
        view.addSubview(greetingMessageView)

        setupGreetingMessageViewConstraints()
    }

    private func setupSearchTextField() {
        view.addSubview(searchTextField)

        searchTextField.rightView = filterButton
        searchTextField.rightViewMode = .always

        setupSearchTextFieldConstraints()
    }

    // Настройка нав бара
    private func setupNavBar() {
//        navigationItem.title = ExcursionsListConstants.NavBar.title
        navigationController?.view.backgroundColor = ExcursionsListConstants.NavBar.backgroundColor

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc
    private func didTapAddButton() {
        output.didAddExcursionButtonTapped()
    }

    private func setupGreetingMessageViewConstraints() {
        greetingMessageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(ExcursionsListConstants.GreetingMessage.height)
            make.left.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
        }
    }

    private func setupSearchTextFieldConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(greetingMessageView.snp.bottom).offset(ExcursionsListConstants.SearchTextField.offset)
            make.left.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
        }
    }

    // Настройка таблицы с экскурсиями
    private func setupTableView() {
        view.addSubview(excursionsTable)
        excursionsTable.backgroundColor = .prog.Dynamic.background

        excursionsTable.layoutMargins = UIEdgeInsets(
            top: ExcursionsListConstants.Screen.paddingTop,
            left: ExcursionsListConstants.Screen.padding,
            bottom: ExcursionsListConstants.Screen.paddingBottom,
            right: ExcursionsListConstants.Screen.padding
        )
        excursionsTable.separatorStyle = .none

        setTableViewDelegate()
        excursionsTable.register(ExcursionCell.self, forCellReuseIdentifier: ExcursionsListConstants.ExcursionCell.reuseId)
        setTableViewConstraints()
    }

    private func setTableViewDelegate() {
        excursionsTable.delegate = self
        excursionsTable.dataSource = self
    }

    private func setTableViewConstraints() {
        excursionsTable.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(ExcursionsListConstants.TableView.offset)
            make.bottom.equalToSuperview()
        }
    }

    private func setupLoader() {
        view.addSubview(loader)
        setLoaderConstraints()
    }

    private func setLoaderConstraints() {
        loader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    private func setupErrorView() {
        view.addSubview(errorView)
        errorView.delegate = self

        errorView.isHidden = true
        setErrorViewConstrints()
    }

    private func setErrorViewConstrints() {
        errorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

// MARK: ExcursionsListViewInput

extension ExcursionsListViewController: ExcursionsListViewInput {
    func hideErrorView() {
        errorView.isHidden = true
        loader.stopAnimating()
    }

    func showErrorView() {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.loader.stopAnimating()
        }
    }

    func reloadView() {
        reload()
    }

    func startLoader() {
        loader.hidesWhenStopped = true
        loader.startAnimating()
    }

    func stopLoader() {
        loader.stopAnimating()
    }

    func showAuthView() {
        let notLoginAlert = UIAlertController(title: "Вы не авторизованы! Необходимо войти в Ваш аккаунт", message: "", preferredStyle: .alert)
        notLoginAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            notLoginAlert.dismiss(animated: true, completion: nil)
        }))
        present(notLoginAlert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource

extension ExcursionsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.itemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExcursionsListConstants.ExcursionCell.reuseId) as? ExcursionCell else {
            return UITableViewCell()
        }
        let excursion = output.item(for: indexPath.row)
        cell.set(excursion: excursion)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ExcursionsListConstants.ExcursionCell.height
    }
}

// MARK: UITableViewDelegate

extension ExcursionsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectCell(at: indexPath)
    }
}

// MARK: ErrorViewDelegate

extension ExcursionsListViewController: ErrorViewDelegate {
    func didRepeatButtonTapped() {
        output.didRepeatButtonTapped()
    }
}
