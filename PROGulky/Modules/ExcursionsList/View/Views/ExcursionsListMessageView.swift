//
//  ExcursionsListMessageView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 26.05.2023.
//

import UIKit
import SnapKit
import Lottie

final class ExcursionsListMessageView: UIView {
    private let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = ExcursionsListConstants.EmptyListAnimationView.labelFont
        label.text = ExcursionsListConstants.EmptyListAnimationView.labelText
        return label
    }()

    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.animation = .named("notFound")
        view.frame = .zero
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.animationSpeed = 0.5
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        animationView.frame = bounds

        addSubviews(message, animationView)
        animationView.play()
        setupConstraints()
    }

    private func setupConstraints() {
        setAnimationConstraints()
        setMessageConstraints()
    }

    private func setAnimationConstraints() {
        animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(ExcursionsListConstants.EmptyListAnimationView.offset)
            make.width.equalTo(ExcursionsListConstants.EmptyListAnimationView.width)
            make.height.equalTo(ExcursionsListConstants.EmptyListAnimationView.height)
        }
    }

    private func setMessageConstraints() {
        message.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
