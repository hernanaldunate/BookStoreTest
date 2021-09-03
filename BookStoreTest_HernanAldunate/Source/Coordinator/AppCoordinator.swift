//
//  AppCoordinator.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let bookStoreCoordinator: BookStoreCoordinator!

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()

        let apiClient = BooksAPIClient(url: "https://raw.githubusercontent.com/ejgteja/files/main/books.json")
        let viewModel = BookStoreViewModel(apiClient: apiClient)
        bookStoreCoordinator = BookStoreCoordinator(presenter: rootViewController, viewModel: viewModel)
    }

    func start() {
        window.rootViewController = rootViewController
        bookStoreCoordinator.start()
        window.makeKeyAndVisible()
    }
}
