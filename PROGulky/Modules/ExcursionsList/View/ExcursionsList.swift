//
//  ExcursionsList.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 10.11.2022.
//

import UIKit

// MARK: - ExcursionsList

final class ExcursionsList: UIView {
    private var excursions: [Excursion] = []

    struct Cells {
        static let excursionCell = "ExcursionCell"
    }

    private var excursionsTableView: UITableView {
        let table = UITableView()
        // table.backgroundColor = .gray
        table.separatorInset = .zero

        return table
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        excursions = fetchData()

        addSubview(excursionsTableView)

        excursionsTableView.translatesAutoresizingMaskIntoConstraints = false
//        excursionsTableView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        excursionsTableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        // excursionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        // excursionsTableView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        excursionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        excursionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        excursionsTableView.delegate = self
        excursionsTableView.dataSource = self

        excursionsTableView.register(ExcursionCell.self, forCellReuseIdentifier: Cells.excursionCell)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ExcursionsList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        excursions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.excursionCell) as! ExcursionCell // swiftlint:disable:this force_cast
        let excursion = excursions[indexPath.row]

        cell.set(excursion: excursion)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension ExcursionsList {
    func fetchData() -> [Excursion] {
        let e1 = Excursion(image: UIImage(named: "picture")!, title: "Интересная Москва", rating: 5.6, parameters: "2 часа | 3 км | 6 точек")
        let e2 = Excursion(image: UIImage(named: "picture")!, title: "Театры Москвы", rating: 4.99, parameters: "2 часа | 3 км | 6 точек")
        let e3 = Excursion(image: UIImage(named: "picture")!, title: "Парки", rating: 3.3, parameters: "2 часа | 3 км | 6 точек")
        let e4 = Excursion(image: UIImage(named: "picture")!, title: "Пешеходная тропа", rating: 4.5, parameters: "2 часа | 3 км | 6 точек")
        let e5 = Excursion(image: UIImage(named: "picture")!, title: "Обзорная", rating: 5.0, parameters: "2 часа | 3 км | 6 точек")

        return [e1, e2, e3, e4, e5]
    }
}
