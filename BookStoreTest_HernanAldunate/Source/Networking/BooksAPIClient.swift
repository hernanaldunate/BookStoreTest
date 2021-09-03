//
//  APIClient.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import Foundation

class BooksAPIClient: APIClientProtocol {
    private let url: String

    init(url: String) {
        self.url = url
    }

    func getData(completion: @escaping ([BookModel]?) -> ()) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = json["results"] as? [String: Any],
                       let books = results["books"] as? [Any] {
                        var models: [BookModel] = []
                        for book in books {
                            if let book = book as? [String: Any] {
                                let bookModel = BookModel(from: book)
                                models.append(bookModel)
                            }
                        }

                        completion(models)
                    } else {
                        completion(nil)
                    }
                }
            } catch let error {
                print("Failed to load: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
