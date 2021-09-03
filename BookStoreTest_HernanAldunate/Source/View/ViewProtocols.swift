//
//  ViewProtocols.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import Foundation

// MARK: - Book store

protocol BookStoreSectionProtocol {
    var id: String { get }
    var books: [BookCellProtocol] { get }

    mutating func addBook(_ book: BookCellProtocol)
}

struct BookStoreSection: BookStoreSectionProtocol {
    var id: String
    var books: [BookCellProtocol]

    mutating func addBook(_ book: BookCellProtocol) {
        books.append(book)
    }
}

// MARK: - Book

protocol BookCellProtocol {
    var coverUrl: String { get }
    var title: String { get }
    var author: String { get }
}

struct BookCell: BookCellProtocol {
    var coverUrl: String
    var title: String
    var author: String
}
