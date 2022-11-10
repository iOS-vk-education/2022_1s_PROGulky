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
    var excursions: [Excursion] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let data = output.getExcursionsListDisplayData()
        excursions = data

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Constants.ExcursionsListScreen.backgroundColor

        setupNavBar()
        setupFilterBar()
        setupTableView()
    }

    // Настройка нав бара
    private func setupNavBar() {
        title = Constants.ExcursionsListNavBar.title

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
        filterBar.heightAnchor.constraint(equalToConstant: Constants.ExcursionsFilterBar.height).isActive = true
    }

    // Настройка таблицы с экскурсиями
    private func setupTableView() {
        view.addSubview(excursionsTable)

        setTableViewDelegate()

        excursionsTable.register(ExcursionCell.self, forCellReuseIdentifier: Constants.ExcursionCell.reuseId)

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

// MARK: ExcursionsListViewInput, UITableViewDelegate, UITableViewDataSource

extension ExcursionsListViewController: ExcursionsListViewInput {
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ExcursionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        excursions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ExcursionCell.reuseId) as! ExcursionCell // swiftlint:disable:this force_cast
        let excursion = excursions[indexPath.row]
        cell.set(excursion: excursion)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.ExcursionCell.height
    }
}
