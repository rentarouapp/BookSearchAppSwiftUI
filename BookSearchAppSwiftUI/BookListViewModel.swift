//
//  BookListViewModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/07.
//
// API通信

import Foundation
import Alamofire
import Combine

final class BookListViewModel: ObservableObject {
    @Published var repositories: BookSearchRepositories = .init(items: [])
    
    private var url: String = "https://www.googleapis.com/books/v1/volumes?q="
    
    private var cancellable = Set<AnyCancellable>()
    
    init(_ searchWord: String) {
        self.fetchSearchRepositories(searchWord: searchWord)
    }
    
    private func fetchSearchRepositories(searchWord: String) {
        // リクエストのURLを作成
        let requestURL = self.url + searchWord
        
        AF.request(requestURL, method: .get).publishDecodable(type: BookSearchRepositories.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let response):
                    self.repositories = response
                case .failure:
                    self.repositories = .init(items: [])
                }
            }
            .store(in: &cancellable)
    }
    
}

