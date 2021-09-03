//
//  BookStoreViewController.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import UIKit

class BookStoreViewController: UIViewController {
    private let sectionInsets = UIEdgeInsets(top: 1, left: 20, bottom: 1, right: 20)
    private let cellSpacing: CGFloat = 1
    private let preferredCellWidth: CGFloat = 100
    private let preferredCellHeight: CGFloat = 200

    var viewModel: BookStoreViewModelProtocol!

    private var dataSource: [BookStoreSectionProtocol] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "\(BookCollectionViewCell.self)")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(SectionHeaderView.self)")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    static func create(with viewModel: BookStoreViewModelProtocol) -> BookStoreViewController {
        let viewController = BookStoreViewController()
        viewController.viewModel = viewModel

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Book Store"

        view.backgroundColor = .white
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.collectionViewLayout.invalidateLayout()
    }

    private func reloadData() {
        viewModel.showBooks { [weak self] dataSource in
            guard let self = self, let dataSource = dataSource else {
                return
            }

            self.dataSource = dataSource
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension BookStoreViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BookCollectionViewCell.self)", for: indexPath) as? BookCollectionViewCell else {
            preconditionFailure("Invalid cell type")
        }

        let model = dataSource[indexPath.section].books[indexPath.row]
        cell.coverUrl = model.coverUrl
        cell.title = model.title
        cell.author = model.author

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(SectionHeaderView.self)", for: indexPath) as? SectionHeaderView else {
                fatalError("Invalid view type")
            }

            headerView.title = "\(dataSource[indexPath.section].id) - \(collectionView.numberOfItems(inSection: indexPath.section)) books"

            return headerView

        default:
            assert(false, "Invalid element type")
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension BookStoreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: preferredCellWidth, height: preferredCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

