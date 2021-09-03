//
//  BookModel.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import Foundation

struct BookModel {
    let isbn: String
    let title: String
    let author: String
    let description: String
    let genre: String
    let coverUrl: String
    let isImported: Bool

    init(from dictionary: [String: Any]) {
        self.isbn = dictionary["isbn"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.genre = dictionary["genre"] as? String ?? ""
        self.coverUrl = dictionary["img"] as? String ?? ""
        self.isImported = dictionary["imported"] as? Bool ?? false
    }
}
