//
//  FavouritesExcursionsMessageView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 25.11.2022.
//

import UIKit
import SnapKit
import Lottie

final class FavouritesExcursionsMessageView: UIView {
    private let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FavouritesExcursionsConstants.MessageView.font
        label.text = FavouritesExcursionsConstants.MessageView.text
        return label
    }()

    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.animation = .named("emptyHeart")
        view.frame = .zero
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.animationSpeed = 0.5
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(message, animationView)
        animationView.play()
        setupConstraints()
    }

    private func setupConstraints() {
        setMessageConstraints()
        setAnimationConstraints()
    }

    private func setAnimationConstraints() {
        animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(FavouritesExcursionsConstants.MessageView.width)
            make.height.equalTo(FavouritesExcursionsConstants.MessageView.height)
        }
    }

    private func setMessageConstraints() {
        message.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(FavouritesExcursionsConstants.MessageView.labelOffset)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(ExcursionsListConstants.Screen.padding)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
