//
//  BookListViewModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/07.
//

import Foundation
import Combine

final class BookListViewModel: NSObject, ObservableObject {
    @Published var booksSearchResponse: BooksSearchResponse = .init(items: [])
    @Published var isFetching: Bool = false
    
    private let apiService = APIService()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let onBooksSearchSubject = PassthroughSubject<BooksSearchRequest, Never>()
    private var cancellables: [AnyCancellable] = []
    
    private func bind() {
        self.cancellables += [
            // 通信結果
            self.onBooksSearchSubject
                .flatMap { [apiService] (request) in
                    apiService.request(with: BooksSearchRequest(searchWord: request.searchWord))
                        .catch { [weak self] error -> Empty<BooksSearchResponse, Never> in
                            if let `self` = self {
                                self.errorSubject.send(error)
                            }
                            return .init()
                        }
                }
                .sink(receiveValue: { [weak self] (response) in
                    guard let self = self else { return }
                    self.isFetching = false
                    self.booksSearchResponse = response
                }),
            // エラー
            self.errorSubject
                .sink(receiveValue: { (error) in
                    self.isFetching = false
                    self.handleAPIError(error: error)
                })
        ]
    }
    
    // キーボードの検索ボタンが押されたときにView側から呼び出す
    func resumeSearch(searchWord: String) {
        self.cancellables.forEach { $0.cancel() }
        self.isFetching = true
        self.bind()
        self.booksSearchResponse = .init(items: [])
        self.onBooksSearchSubject.send(BooksSearchRequest(searchWord: searchWord))
    }
    
    // 通信をキャンセルする
    func cancel() {
        self.isFetching = false
        self.cancellables.forEach { $0.cancel() }
        self.booksSearchResponse = .init(items: [])
    }
    
    // API通信のエラーをさばく
    private func handleAPIError(error: APIServiceError) {
        switch error {
        case .invalidURL:
            print("invalidURL")
        case .responseError:
            print("responseError")
        case let .parseError(error):
            print("parseError")
        }
    }
    
}

