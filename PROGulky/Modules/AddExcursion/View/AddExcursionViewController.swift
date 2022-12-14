//
//  AddExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit

// MARK: - AddExcursionViewController

final class AddExcursionViewController: UIViewController {
    var output: AddExcursionViewOutput!

    private let addImageView = UIImageView(frame: .zero)
    private let titleField = UITextField(frame: .zero)
    private let descriptionField = UITextView(frame: .zero)
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var amountOfLinesToBeShown: CGFloat = 6

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
        navigationItem.title = AddExcursionConstants.NavBar.title
        navigationController?.view.backgroundColor = AddExcursionConstants.NavBar.backgroundColor

        let rightBarButtonItem = UIBarButtonItem(
            title: AddExcursionConstants.NavBar.rightBarButtonItemText,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: nil
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
        titleField.placeholder = AddExcursionConstants.TitleField.placeholder
        titleField.layer.cornerRadius = AddExcursionConstants.TitleField.cornerRadius
        titleField.returnKeyType = .next
        titleField.delegate = self
        titleField.addDoneButtonOnKeyboard()
    }

    private func configureDescriptionField() {
        descriptionField.layer.masksToBounds = true
        descriptionField.textColor = AddExcursionConstants.DescriptionField.textColor
        descriptionField.layer.cornerRadius = AddExcursionConstants.DescriptionField.cornerRadius
        descriptionField.font = UIFont.systemFont(ofSize: 15)
        descriptionField.delegate = self
        descriptionField.text = "Placeholder"
        descriptionField.textColor = UIColor.lightGray
        descriptionField.addDoneButtonOnKeyboard()
    }

    private func configureTableView() {
        setTableViewDelegate()

        tableView.backgroundColor = UIColor.prog.Dynamic.background

        tableView.register(SelectedPlaceCell.self, forCellReuseIdentifier: AddExcursionConstants.TableView.SelectedPlaceCell.reuseId)
        tableView.register(AddPlaceCell.self, forCellReuseIdentifier: AddExcursionConstants.TableView.AddPlaceButtonCell.reuseId)
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
        addImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                .offset(AddExcursionConstants.Image.marginTop)
            make.centerX.equalToSuperview()
            make.width.equalTo(AddExcursionConstants.Image.width)
            make.height.equalTo(AddExcursionConstants.Image.height)
        }
    }

    private func setTitleFieldConstraints() {
        titleField.snp.makeConstraints { make in
            make.top.equalTo(self.addImageView.snp.bottom)
                .offset(AddExcursionConstants.TitleField.marginTop)
            make.leading.equalToSuperview()
                .offset(AddExcursionConstants.Screen.padding)
            make.trailing.equalToSuperview()
                .offset(-AddExcursionConstants.Screen.padding)
            make.height.equalTo(AddExcursionConstants.TitleField.height)
        }
    }

    private func setDescriptionFieldConstraints() {
        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(self.titleField.snp.bottom)
                .offset(AddExcursionConstants.DescriptionField.marginTop)
            make.leading.equalToSuperview()
                .offset(AddExcursionConstants.Screen.padding)
            make.trailing.equalToSuperview()
                .offset(-AddExcursionConstants.Screen.padding)
            make.height.equalTo(
                AddExcursionConstants.DescriptionField.minHeight)
        }
    }

    private func setTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionField.snp.bottom)
                .offset(AddExcursionConstants.TableView.marginTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddExcursionConstants.TableView.SelectedPlaceCell.reuseId) as? SelectedPlaceCell else {
                return UITableViewCell()
            }
//            let place = output.place(for: indexPath)
//            cell.set(place: place)

            return cell
        case .AddButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddExcursionConstants.TableView.AddPlaceButtonCell.reuseId) as? AddPlaceCell else {
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

// MARK: UITextViewDelegate

extension AddExcursionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}

// MARK: UITextFieldDelegate

extension AddExcursionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionField.becomeFirstResponder()
        return true
    }
}
