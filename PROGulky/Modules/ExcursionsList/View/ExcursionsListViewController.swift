//
//  ExcursionsListViewController.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 31/10/2022.
//

import UIKit

// MARK: - ExcursionsListViewController

final class ExcursionsListViewController: UIViewController {
    var output: ExcursionsListViewOutput!

    private let filterBar = ExcursionsFilterBarView(frame: .zero)
    private var excursionsTable = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        output.didLoadView()
    }

    private func setupUI() {
        view.backgroundColor = ExcursionsListConstants.Screen.backgroundColor

        setupNavBar()
        setupFilterBar()
        setupTableView()
    }

    // Настройка нав бара
    private func setupNavBar() {
        title = ExcursionsListConstants.ExcursionsListNavBar.title

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc
    private func didTapAddButton() {}

    // Настройка топ бара
    private func setupFilterBar() {
        view.addSubview(filterBar)

        setupFilterBarConstraints()
    }

    private func setupFilterBarConstraints() {
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        filterBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterBar.heightAnchor.constraint(equalToConstant: ExcursionsListConstants.ExcursionsFilterBar.height).isActive = true
    }

    // Настройка таблицы с экскурсиями
    private func setupTableView() {
        view.addSubview(excursionsTable)

        setTableViewDelegate()

        excursionsTable.register(ExcursionCell.self, forCellReuseIdentifier: ExcursionsListConstants.ExcursionCell.reuseId)

        setTableViewConstraints()
    }

    private func setTableViewDelegate() {
        excursionsTable.delegate = self
        excursionsTable.dataSource = self
    }

    private func setTableViewConstraints() {
        excursionsTable.translatesAutoresizingMaskIntoConstraints = false
        excursionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        excursionsTable.topAnchor.constraint(equalTo: filterBar.bottomAnchor).isActive = true
        excursionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        excursionsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ExcursionsListViewController: ExcursionsListViewInput {
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
