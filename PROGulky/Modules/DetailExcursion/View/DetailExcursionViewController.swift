//
//  DetailExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit
import SnapKit

// MARK: - DetailExcursionViewController

final class DetailExcursionViewController: UIViewController {
    var output: DetailExcursionViewOutput!

    private var excursionImageView = UIImageView(frame: .zero)
    private var detailExcursionInfoView = DetailExcursionInfoView()
    private var tableView = UITableView()
    private let likeButton = UIButton(frame: .zero)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()

        output.didLoadView()
    }

    private func setupImage(with image: String?) {
        if let image = image {
            let imageURL = "\(ExcursionsListConstants.Api.imageURL)/\(image)"
            excursionImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholderImage"))
        } else {
            excursionImageView.image = UIImage(named: "placeholderImage")
        }
    }

    @objc
    private func didLikeButtonTapped() {
        output.didLikeButtonTapped()
    }

    private func setupUI() {
        view.addSubviews(
            excursionImageView,
            detailExcursionInfoView,
            tableView,
            likeButton
        )
        view.backgroundColor = ExcursionsListConstants.Screen.backgroundColor

        configureImageView()
        configureDetailExcursionInfoView()
        configureTableView()
        configureLikeButton()
    }

    private func configureImageView() {
        excursionImageView.clipsToBounds = true
        excursionImageView.layer.masksToBounds = true
        excursionImageView.contentMode = .scaleAspectFill
    }

    private func configureDetailExcursionInfoView() {
        detailExcursionInfoView.backgroundColor = DetailExcursionConstants.InfoView.backgroundColor
        detailExcursionInfoView.layer.cornerRadius = DetailExcursionConstants.InfoView.cornerRadius
        detailExcursionInfoView.clipsToBounds = true
        detailExcursionInfoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureTableView() {
        setTableViewDelegate()

        tableView.backgroundColor = UIColor.prog.Dynamic.background

        tableView.register(PlaceCell.self, forCellReuseIdentifier: DetailExcursionConstants.TableView.PlaceCell.reuseId)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DetailExcursionConstants.TableView.DescriptionCell.reuseId)
    }

    private func configureLikeButton() {
        likeButton.addTarget(self, action: #selector(didLikeButtonTapped), for: .touchUpInside)
        likeButton.tintColor = .white
    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupConstraints() {
        setImageConstraints()
        setDetailExcursionInfoViewConstraints()
        setTableViewConstraints()
        setLikeButtonConstraints()
        setNotAuthViewConstraints()
    }

    private func setImageConstraints() {
        excursionImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
                .offset(DetailExcursionConstants.Image.marginTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(DetailExcursionConstants.Image.height)
        }
    }

    private func setDetailExcursionInfoViewConstraints() {
        detailExcursionInfoView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(self.excursionImageView.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.heightInImage)
            make.bottom.greaterThanOrEqualTo(self.excursionImageView.snp.bottom)
            make.height.greaterThanOrEqualTo(DetailExcursionConstants.InfoView.height)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }

    private func setTableViewConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(self.detailExcursionInfoView.snp.bottom)
                .offset(DetailExcursionConstants.TableView.marginTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setLikeButtonConstraints() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.topAnchor.constraint(equalTo: excursionImageView.topAnchor, constant: DetailExcursionConstants.LikeButton.marginTop).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: excursionImageView.trailingAnchor, constant: DetailExcursionConstants.LikeButton.marginRight).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.LikeButton.height).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: DetailExcursionConstants.LikeButton.width).isActive = true
    }
}

// MARK: DetailExcursionViewInput

extension DetailExcursionViewController: DetailExcursionViewInput {
    func configureLikeButton(isLiked: Bool) {
        likeButton.setBackgroundImage(isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }

    func showAuthView() {
        let notLoginAlert = UIAlertController(title: "Вы не авторизованы! Необходимо войти в Ваш аккаунт", message: "", preferredStyle: .alert)
        notLoginAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            notLoginAlert.dismiss(animated: true, completion: nil)
        }))
        present(notLoginAlert, animated: true, completion: nil)
    }

    func showErrorView() {
        let errorAlert = UIAlertController(title: "Произошла ошибка. Повторите позже", message: "", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        present(errorAlert, animated: true, completion: nil)
    }

    func configure(viewModel: DetailExcursionViewModel) {
        setupImage(with: viewModel.image)
        detailExcursionInfoView.set(excursion: viewModel.infoViewModel)
    }
}

extension DetailExcursionViewController: UITableViewDelegate {
}

// MARK: UITableViewDataSource

extension DetailExcursionViewController: UITableViewDataSource {
    // Количество секций таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        DetailExcursionSettingsSections.allCases.count
    }

    // Количество ячеек в каждой секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = DetailExcursionSettingsSections(rawValue: section) else { return 0 }

        switch section {
        case .Places:
            return output.placesCount
        case .Description:
            return DetailExcursionSettingsSections.DescriptionOptions.allCases.count
        }
    }

    // Ячейки в секции
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DetailExcursionSettingsSections(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .Places:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailExcursionConstants.TableView.PlaceCell.reuseId) as? PlaceCell else {
                return UITableViewCell()
            }
            let place = output.place(for: indexPath)
            cell.set(place: place)

            return cell
        case .Description:
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
        guard let text = DetailExcursionSettingsSections(rawValue: section)?.description else { return UIView() }

        let view = DetailExcursionHeaderInSectionView()
        view.set(headerText: text)

        return view
    }

    // Высоты ячеек в секциях
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = DetailExcursionSettingsSections(rawValue: indexPath.section) else { return 0 }

        switch section {
        case .Places:
            return DetailExcursionConstants.TableView.PlaceCell.height
        case .Description:
            return UITableView.automaticDimension
        }
    }
}
