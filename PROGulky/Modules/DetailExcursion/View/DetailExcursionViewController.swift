//
//  DetailExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - DetailExcursionViewController

final class DetailExcursionViewController: UIViewController {
    var output: DetailExcursionViewOutput!

    private var excursionImageView = UIImageView(frame: .zero)
    private var detailExcursionInfoView = DetailExcursionInfoView(frame: .zero)
    private var tableView = UITableView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.didLoadView()
        view.addSubviews(
            excursionImageView,
            detailExcursionInfoView,
            tableView
        )
        setupUI()
        setupConstraints()
        setDisplayData()
    }

    private func setDisplayData() {
        excursionImageView.image = UIImage(named: output.image)
        detailExcursionInfoView.set(excursion: output.detailExcursionInfoViewModel)
    }

    private func setupUI() {
        view.backgroundColor = ExcursionsListConstants.Screen.backgroundColor

        configureImageView()
        configureDetailExcursionInfoView()
        configureTableView()
    }

    private func configureImageView() {
        excursionImageView.clipsToBounds = true
    }

    private func configureDetailExcursionInfoView() {
        detailExcursionInfoView.backgroundColor = DetailExcursionConstants.InfoView.backgroundColor
        detailExcursionInfoView.layer.cornerRadius = DetailExcursionConstants.InfoView.cornerRadius

        // Конфигурация тени
        detailExcursionInfoView.layer.shadowColor = DetailExcursionConstants.InfoView.shadowColor
        detailExcursionInfoView.layer.shadowOpacity = DetailExcursionConstants.InfoView.shadowOpacity
        detailExcursionInfoView.layer.shadowRadius = DetailExcursionConstants.InfoView.shadowRadius
    }

    private func configureTableView() {
        setTableViewDelegate()

        tableView.register(PlaceCell.self, forCellReuseIdentifier: DetailExcursionConstants.TableView.PlaceCell.reuseId)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DetailExcursionConstants.TableView.DescriptionCell.reuseId)
    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupConstraints() {
        setImageConstraints()
        setDetailExcursionInfoViewConstraints()
        setTableViewConstraints()
    }

    private func setImageConstraints() {
        excursionImageView.translatesAutoresizingMaskIntoConstraints = false
        excursionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DetailExcursionConstants.Image.marginTop).isActive = true
        excursionImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        excursionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        excursionImageView.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.Image.height).isActive = true
    }

    private func setDetailExcursionInfoViewConstraints() {
        detailExcursionInfoView.translatesAutoresizingMaskIntoConstraints = false
        detailExcursionInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailExcursionInfoView.topAnchor.constraint(equalTo: excursionImageView.bottomAnchor, constant: DetailExcursionConstants.InfoView.heightInImage).isActive = true
        detailExcursionInfoView.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.height).isActive = true
        detailExcursionInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DetailExcursionConstants.InfoView.marginLeft).isActive = true
        detailExcursionInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: DetailExcursionConstants.InfoView.marginRight).isActive = true
    }

    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: detailExcursionInfoView.bottomAnchor, constant: DetailExcursionConstants.TableView.marginTop).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc
    private func didTapBackButton() {
        // dismiss(animated: true)
    }
}

// MARK: DetailExcursionViewInput

extension DetailExcursionViewController: DetailExcursionViewInput {
}

extension DetailExcursionViewController: UITableViewDelegate {
}

// MARK: UITableViewDataSource

extension DetailExcursionViewController: UITableViewDataSource {
    // Количество секций таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    // Количество ячеек в каждой секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return output.placesCount
        } else {
            return 1
        }
    }

    // Ячейки в секции
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailExcursionConstants.TableView.PlaceCell.reuseId) as? PlaceCell else {
                return UITableViewCell()
            }
            let place = output.place(for: indexPath)
            cell.set(place: place)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailExcursionConstants.TableView.DescriptionCell.reuseId) as? DescriptionCell else {
                return UITableViewCell()
            }
            let description = output.description
            cell.set(description: description)

            return cell
        }
    }

    // Вью заголовка секций
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        let label = UILabel()
        view.backgroundColor = DetailExcursionConstants.TableView.HeaderInSection.backgroundColor

        view.addSubview(label)
        label.textColor = DetailExcursionConstants.TableView.HeaderInSection.textColor
        label.font = DetailExcursionConstants.TableView.HeaderInSection.font

        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DetailExcursionConstants.Screen.padding).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        if section == 0 {
            label.text = DetailExcursionConstants.TableView.SectionPlacesHeader.text
            return view
        } else {
            label.text = DetailExcursionConstants.TableView.SectionDescriptionHeader.text
            return view
        }
    }

    // Размеры ячеев в секциях
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return DetailExcursionConstants.TableView.PlaceCell.height
        } else {
            // Я не знаю как тут сделать автоматическую высоту ячейки под размер контента
            return 200
        }
    }
}
