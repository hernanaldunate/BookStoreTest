//
//  BookStoreViewModel.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import Foundation

protocol BookStoreViewModelProtocol: AnyObject {
    func showBooks(completion: @escaping ([BookStoreSectionProtocol]?) -> ())
}

/// View model concrete implementation
class BookStoreViewModel: BookStoreViewModelProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func showBooks(completion: @escaping ([BookStoreSectionProtocol]?) -> ()) {
        apiClient.getData() { model in
            guard let model = model else {
                DispatchQueue.main.async {
                    completion(nil)
                }

                return
            }

            // The view model transforms the model into a data source for the view controller, this way the view controller is decoupled from the model
            // Although the model is a list of books, for the view each book is grouped in its corresponding section
            var dataSource: [BookStoreSectionProtocol] = []
            for book in model {
                let bookCell = BookCell(coverUrl: book.coverUrl,
                                        title: book.title,
                                        author: book.author)

                if let index = dataSource.firstIndex(where: { $0.id == String(book.genre) }) {
                    dataSource[index].addBook(bookCell)
                } else {
                    dataSource.append(BookStoreSection(id: String(book.genre), books: [bookCell]))
                }
            }

            DispatchQueue.main.async {
                completion(dataSource)
            }
        }
    }
}
