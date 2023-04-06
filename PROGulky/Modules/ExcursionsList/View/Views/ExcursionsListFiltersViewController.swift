//
//  ExcursionsListFiltersViewController.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.03.2023.
//

import UIKit

// MARK: - ExcursionsListFiltersConstants

private struct ExcursionsListFiltersConstants {
    enum StackView {
        static let height: CGFloat = 35
        static let topOffset: CGFloat = 15
        static let widthOffset: CGFloat = -32
        static let spacing: CGFloat = 15
    }

    enum DistanceLabel {
        static let text: String = "Длина маршрута"
        static let inset: CGFloat = 20
    }

    enum SubmitButton {
        static let height: CGFloat = 50
        static let cornerRadius: CGFloat = 12
        static let text: String = "Применить"
    }
}

// MARK: - ExcursionsListFiltersViewController

final class ExcursionsListFiltersViewController: UIViewController {
    var output: ExcursionsListFiltersViewOutput!

    var distances: [FilterButtonViewModel] // вью модель (опций) фильтра по "Дистанции"

    // MARK: - Subviews

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
        label.text = ExcursionsListFiltersConstants.DistanceLabel.text
        return label
    }()

    private let _scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let submitButton = UIButton()

    private var currentHeight: CGFloat {
        didSet {
            updatePreferredContentSize()
        }
    }

    // MARK: - Init

    init(initialHeight: CGFloat, delegate: ExcursionsListFiltersViewOutput) {
        output = delegate
        distances = output.getDistanceFilterButtons()

        currentHeight = initialHeight
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewCoontroller

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        updatePreferredContentSize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.setNeedsLayout()
    }

    // MARK: - Setup

    private func setupSubviews() {
        view.backgroundColor = .prog.Dynamic.background
        view.addSubview(_scrollView)

        configureScrollView()
        configureDurationLabel()
        configureStackView()
        confugureSubmitButton()
    }

    private func configureScrollView() {
        _scrollView.alwaysBounceVertical = true
        setScrollViewConstratints()
    }

    private func configureDurationLabel() {
        _scrollView.addSubview(distanceLabel)
        setDurationLabelConstraint()
    }

    private func configureStackView() {
        _scrollView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = ExcursionsListFiltersConstants.StackView.spacing

        addButtonsToStackView()
        setStackViewConstratins()
    }

    private func confugureSubmitButton() {
        _scrollView.addSubview(submitButton)

        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .prog.Dynamic.primary
        submitButton.layer.cornerRadius = ExcursionsListFiltersConstants.SubmitButton.cornerRadius
        submitButton.setTitle(ExcursionsListFiltersConstants.SubmitButton.text, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)

        setSubmitButtonConstraints()
    }

    @objc
    func submitButtonTapped() {
        output.didSubmitButtonTapped()
    }

    // MARK: Constraints

    private func setScrollViewConstratints() {
        _scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setDurationLabelConstraint() {
        distanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(ExcursionsListFiltersConstants.DistanceLabel.inset)
            make.left.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
        }
    }

    private func setStackViewConstratins() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom).offset(ExcursionsListFiltersConstants.StackView.topOffset)
            make.width.equalToSuperview().offset(ExcursionsListFiltersConstants.StackView.widthOffset)
            make.left.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
            make.height.equalTo(ExcursionsListFiltersConstants.StackView.height)
        }
    }

    private func setSubmitButtonConstraints() {
        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
            make.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
            make.height.equalTo(ExcursionsListFiltersConstants.SubmitButton.height)
        }
    }

    private var selectedDistanceButton: ChipsButton? // Выбранная кнопка фильтра длины

    private func addButtonsToStackView() {
        for d in distances {
            let button = ChipsButton()
            if d.isSelected {
                button.setSelectedColor()
                selectedDistanceButton = button
            }
            button.setTitle(d.title, for: .normal)
            button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc
    func filterButtonTapped(selectableButton: ChipsButton) {
        guard let title = selectableButton.titleLabel?.text else { return }
        output.didDistanceFilterButtonTapped(with: title)

        selectedDistanceButton?.setDefaultColor() // Выбранная (старая) становится серой
        selectableButton.setSelectedColor() // Выбираемая (сейчас нажатая) становится синей
        selectedDistanceButton = selectableButton
    }

    // MARK: - Private methods

    private func updatePreferredContentSize() {
        _scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: currentHeight)
        preferredContentSize = _scrollView.contentSize
    }
}
