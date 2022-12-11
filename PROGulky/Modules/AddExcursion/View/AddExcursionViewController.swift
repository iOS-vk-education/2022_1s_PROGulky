//
//  AddExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - AddExcursionViewController

final class AddExcursionViewController: UIViewController {
    var output: AddExcursionViewOutput!

    private let addImageView = UIImageView(frame: .zero)
    private let titleField = UITextField(frame: .zero)
    private let descriptionField = UITextView(frame: .zero)
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.addSubviews(
            addImageView,
            titleField,
            descriptionField,
            tableView
        )

        view.backgroundColor = .prog.Dynamic.background

        configureNavBar()
        configureImageView()
        configureTitleTextField()
        configureDescriptionField()
        configureTableView()
    }

    private func configureNavBar() {
        navigationItem.title = CreateExcursionConstants.NavBar.title
        navigationController?.view.backgroundColor = CreateExcursionConstants.NavBar.backgroundColor

        let rightBarButtonItem = UIBarButtonItem(
            title: CreateExcursionConstants.NavBar.rightBarButtonItemText,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: ""
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc
    private func didTapAddButton() {
    }

    private func configureImageView() {
        addImageView.image = UIImage(systemName: "square.and.pencil")
        addImageView.clipsToBounds = true
        addImageView.contentMode = .scaleAspectFill
    }

    private func configureTitleTextField() {
        titleField.layer.masksToBounds = true // Убирает дефолтную рамку
        titleField.borderStyle = UITextField.BorderStyle.roundedRect
        titleField.placeholder = CreateExcursionConstants.TitleField.placeholder
        titleField.layer.cornerRadius = CreateExcursionConstants.TitleField.cornerRadius
    }

    private func configureDescriptionField() {
        descriptionField.layer.masksToBounds = true
        descriptionField.textColor = CreateExcursionConstants.DescriptionField.textColor
        descriptionField.layer.cornerRadius = CreateExcursionConstants.DescriptionField.cornerRadius
    }

    private func configureTableView() {
        setTableViewDelegate()

        tableView.backgroundColor = UIColor.prog.Dynamic.background

        tableView.register(SelectedPlaceCell.self, forCellReuseIdentifier: CreateExcursionConstants.TableView.SelectedPlaceCell.reuseId)
        tableView.register(AddPlaceCell.self, forCellReuseIdentifier: CreateExcursionConstants.TableView.AddPlaceButtonCell.reuseId)
    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupConstraints() {
        setAddImageViewConstraints()
        setTitleFieldConstraints()
        setDescriptionFieldConstraints()
        setTableViewConstraints()
    }

    private func setAddImageViewConstraints() {
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CreateExcursionConstants.Image.marginTop).isActive = true
        addImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addImageView.widthAnchor.constraint(equalToConstant: CreateExcursionConstants.Image.width).isActive = true
        addImageView.heightAnchor.constraint(equalToConstant: CreateExcursionConstants.Image.height).isActive = true
    }

    private func setTitleFieldConstraints() {
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.topAnchor.constraint(equalTo: addImageView.bottomAnchor, constant: CreateExcursionConstants.TitleField.marginTop).isActive = true
        titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CreateExcursionConstants.Screen.padding).isActive = true
        titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CreateExcursionConstants.Screen.padding).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: CreateExcursionConstants.TitleField.height).isActive = true
    }

    private func setDescriptionFieldConstraints() {
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        descriptionField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: CreateExcursionConstants.DescriptionField.marginTop).isActive = true
        descriptionField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CreateExcursionConstants.Screen.padding).isActive = true
        descriptionField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CreateExcursionConstants.Screen.padding).isActive = true
        descriptionField.heightAnchor.constraint(equalToConstant: CreateExcursionConstants.DescriptionField.height).isActive = true
    }

    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: CreateExcursionConstants.TableView.marginTop).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension AddExcursionViewController: AddExcursionViewInput {
}

extension AddExcursionViewController: UITableViewDelegate {
}

// MARK: UITableViewDataSource

extension AddExcursionViewController: UITableViewDataSource {
    // Количество секций таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        CreateExcursionSettingsSections.allCases.count
    }

    // Количество ячеек в каждой секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = CreateExcursionSettingsSections(rawValue: section) else { return 0 }

        switch section {
        case .SelectedPlaces:
            return output.selectedPlacesCount()
        case .AddButton:
            return 1
        }
    }

    // Ячейки в секции
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = CreateExcursionSettingsSections(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .SelectedPlaces:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateExcursionConstants.TableView.SelectedPlaceCell.reuseId) as? SelectedPlaceCell else {
                return UITableViewCell()
            }
//            let place = output.place(for: indexPath)
//            cell.set(place: place)

            return cell
        case .AddButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateExcursionConstants.TableView.AddPlaceButtonCell.reuseId) as? AddPlaceCell else {
                return UITableViewCell()
            }
//            let description = output.description
//            cell.set(description: description)

            return cell
        }
    }

//    // Высоты ячеек в секциях
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = DetailExcursionSettingsSections(rawValue: indexPath.section) else { return 0 }
//
//        switch section {
//        case .Places:
//            return DetailExcursionConstants.TableView.PlaceCell.height
//        case .Description:
//            return UITableView.automaticDimension
//        }
//    }
}
