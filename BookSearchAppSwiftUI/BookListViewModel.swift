//
//  BookListViewModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/07.
//

import Foundation
import Combine
import PKHUD

final class BookListViewModel: NSObject, ObservableObject {
    @Published var booksSearchResponse: BooksSearchResponse = .init(items: [])
    
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
                        .catch { [weak self] error -> Empty<BooksSearchResponse, Never> in
                            self?.errorSubject.send(error)
                            return .init()
                        }
                }
                .sink(receiveValue: { [weak self] (response) in
                    guard let self = self else { return }
                    self.booksSearchResponse = response
                }),
            errorSubject
                .sink(receiveValue: { (error) in
                    print("API Error")
                })
        ]
    }
    
    // キーボードの検索ボタンが押されたときにView側から呼び出す
    func resumeSearch(searchWord: String) {
        self.onBooksSearchSubject.send(BooksSearchRequest(searchWord: searchWord))
    }
    
}

