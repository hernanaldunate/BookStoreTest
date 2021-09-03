//
//  BookStoreCoordinator.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import UIKit

class BookStoreCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var bookStoreViewController: BookStoreViewController!
    private var viewModel: BookStoreViewModelProtocol

    init(presenter: UINavigationController, viewModel: BookStoreViewModelProtocol) {
        self.presenter = presenter
        self.viewModel = viewModel
    }

    func start() {
        let bookStoreViewController = BookStoreViewController()
        bookStoreViewController.viewModel = viewModel
        self.bookStoreViewController = bookStoreViewController

        presenter.pushViewController(bookStoreViewController, animated: true)
    }
}
