//
//  BookCollectionViewCell.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    var coverUrl: String!
    var title: String!
    var author: String!

    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image-placeholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = author
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        coverImageView.loadImage(from: coverUrl)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        coverImageView.image = UIImage(named: "image-placeholder")
        titleLabel.text = ""
        authorLabel.text = ""
    }
}
