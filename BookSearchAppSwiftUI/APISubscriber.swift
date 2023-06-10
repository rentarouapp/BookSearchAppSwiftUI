//
//  APISubscriber.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/08.
//

import Foundation

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

struct BooksSearchRequest: APIRequestType {
    typealias Response = BooksSearchResponse
    
    var path: String {
        return "volumes?"
    }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: self.searchWord),
            .init(name: "maxResults", value: "12")
        ]
    }
    
    public let searchWord: String
    
    init(searchWord: String) {
        self.searchWord = searchWord
    }
    
}