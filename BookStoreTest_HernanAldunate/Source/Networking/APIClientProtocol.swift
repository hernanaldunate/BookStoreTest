//
//  APIClientProtocol.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import Foundation

protocol APIClientProtocol {
    func getData(completion: @escaping ([BookModel]?) -> ())
}
