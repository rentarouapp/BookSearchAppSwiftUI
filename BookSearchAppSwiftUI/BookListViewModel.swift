//
//  BookListViewModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/07.
//

import Foundation
import Combine

final class BookListViewModel: NSObject, ObservableObject {
    @Published var repositories: BookSearchRepositories = .init(items: [])
    
    private let apiService = APIService()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let onBooksSearchSubject = PassthroughSubject<BooksSearchRequest, Never>()
    private var cancellables: [AnyCancellable] = []
    
    override init() {
        super.init()
        self.bind()
    }
    
    private func bind() {
        self.cancellables += [
            self.onBooksSearchSubject
                .flatMap { [apiService] (request) in
                    apiService.request(with: BooksSearchRequest(searchWord: request.searchWord))
                        .catch { [weak self] error -> Empty<BookSearchRepositories, Never> in
                            self?.errorSubject.send(error)
                            return .init()
                        }
                }
                .sink(receiveValue: { [weak self] (response) in
                    guard let self = self else { return }
                    self.repositories = response
                }),
            errorSubject
                .sink(receiveValue: { [weak self] (error) in
                    guard let self = self else { return }
                    print("API Error")
                })
        ]
    }
    
    func resumeSearch(searchWord: String) {
        self.onBooksSearchSubject.send(BooksSearchRequest(searchWord: searchWord))
    }
    
}

