//
//  FavouritesExcursionsViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit

// MARK: - FavouritesExcursionsViewController

final class FavouritesExcursionsViewController: UIViewController {
    var output: FavouritesExcursionsViewOutput!

    private let loader = UIActivityIndicatorView(frame: .zero)
    private let errorView = ErrorView(frame: .zero)
    private var excursionsTable = UITableView(frame: .zero, style: .insetGrouped)
    private let emptyListMessage = FavouritesExcursionsMessageView(frame: .zero)
    private let notLoginMessage = NotLoginMessageView(frame: .zero)
    private let refreshControl = UIRefreshControl()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        setupUI()
        setupConstraints()

        output.didLoadView()
    }

    @objc
    private func refresh() {
        output.didPullResfresh()
    }

    private func setupUI() {
        view.backgroundColor = .prog.Dynamic.background
        setupNavBar()
        setupLoader()
        setupErrorView()
        setupTableView()
        setupEmptyListMessageView()
        setupNotLoginMessageView()
    }

    func reload() {
        excursionsTable.reloadData()
    }

    private func setupLoader() {
        view.addSubview(loader)
    }

    // Настройка нав бара
    private func setupNavBar() {
        navigationItem.title = FavouritesExcursionsConstants.NavBar.title
        navigationController?.view.backgroundColor = ExcursionsListConstants.NavBar.backgroundColor
    }

    private func setupErrorView() {
        view.addSubview(errorView)
        errorView.delegate = self

        errorView.isHidden = true
        setErrorViewConstrints()
    }

    // Настройка таблицы с экскурсиями
    private func setupTableView() {
        excursionsTable.backgroundColor = .prog.Dynamic.background

        excursionsTable.layoutMargins = UIEdgeInsets(
            top: ExcursionsListConstants.Screen.paddingTop,
            left: ExcursionsListConstants.Screen.padding,
            bottom: ExcursionsListConstants.Screen.paddingBottom,
            right: ExcursionsListConstants.Screen.padding
        )
        excursionsTable.separatorStyle = .none

        view.addSubview(excursionsTable)

        setTableViewDelegate()

        excursionsTable.register(ExcursionCell.self, forCellReuseIdentifier: ExcursionsListConstants.FavoritesExcursionsCell.reuseId)

        setTableViewConstraints()
    }

    private func setTableViewDelegate() {
        excursionsTable.delegate = self
        excursionsTable.dataSource = self
        excursionsTable.refreshControl = refreshControl
    }

    private func setupEmptyListMessageView() {
        view.addSubview(emptyListMessage)
        emptyListMessage.isHidden = true
    }

    private func setupNotLoginMessageView() {
        view.addSubview(notLoginMessage)
        notLoginMessage.isHidden = true
    }

    private func setupConstraints() {
        setupEmptyListMessageViewConstraints()
        setupNotLoginMessageViewConstraints()
        setupLoaderConstraints()
    }

    private func setupEmptyListMessageViewConstraints() {
        emptyListMessage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func setupNotLoginMessageViewConstraints() {
        notLoginMessage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func setupLoaderConstraints() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setTableViewConstraints() {
        excursionsTable.translatesAutoresizingMaskIntoConstraints = false
        excursionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        excursionsTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        excursionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        excursionsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setErrorViewConstrints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        errorView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

// MARK: FavouritesExcursionsViewInput

extension FavouritesExcursionsViewController: FavouritesExcursionsViewInput {
    func showErrorView() {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.loader.stopAnimating()
        }
    }

    func hideEmptyListView() {
        emptyListMessage.isHidden = true
    }

    func reloadView() {
        reload()
        refreshControl.endRefreshing()
    }

    func showEmptyListView() {
        emptyListMessage.isHidden = false
    }

    func startLoader() {
        loader.hidesWhenStopped = true
        loader.startAnimating()
    }

    func stopLoader() {
        loader.stopAnimating()
    }

    func showNotAuthView() {
        notLoginMessage.isHidden = false
    }
}

// MARK: UITableViewDataSource

extension FavouritesExcursionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.itemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExcursionsListConstants.FavoritesExcursionsCell.reuseId) as? ExcursionCell else {
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

extension FavouritesExcursionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectCell(at: indexPath)
    }
}

// MARK: ErrorViewDelegate

extension FavouritesExcursionsViewController: ErrorViewDelegate {
    func didRepeatButtonTapped() {
        output.didRepeatButtonTapped()
    }
}
