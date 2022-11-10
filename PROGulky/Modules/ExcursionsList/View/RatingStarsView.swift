//
//  RatingStarsView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 07.11.2022.
//

import UIKit

// MARK: - RatingStarsView

class RatingStarsView: UIView {
    var ratingStarsCollection = UICollectionView()
    ratingStarsCollection.delegate = self
    ratingStarsCollection.dataSource = self

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = 200
        let layout = ratingStarsCollection.collectionViewLayout as UICollectionViewLayout
        // layout.itemSize = CGSize(width: 10, height: 10)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension RatingStarsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell // swiftlint:disable:this force_cast
        cell.textLabel.text = "1"
        return cell
    }
}

// MARK: - MyCell

class MyCell: UICollectionViewCell {
    weak var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        self.textLabel = textLabel

        contentView.backgroundColor = .lightGray
        self.textLabel.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        fatalError("Interface Builder is not supported!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        fatalError("Interface Builder is not supported!")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        textLabel.text = nil
    }
}
