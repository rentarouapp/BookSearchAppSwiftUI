//
//  BooksListView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct BooksListView: View {
    
    // ViewModel
    @StateObject private var bookListViewModel = BookListViewModel()
    
    @State private var searchText: String = ""
    @FocusState var focus: Bool
    
    // Realm
    @EnvironmentObject var realmViewModel: RealmViewModel
    
    // UI Style
    private let rowInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    // test
    private var isMock = false
    
    // 検索上限数
    let maxResults: Int = 12
    
    var body: some View {
        
        // Mock or Production
        let books: [BookItem] = isMock ? [
            Constants.getSampleBookItem(mockPerson: .steve_jobs),
            Constants.getSampleBookItem(mockPerson: .tim_cook),
            Constants.getSampleBookItem(mockPerson: .jony_ive)
        ] : self.bookListViewModel.booksSearchResponse.items ?? []
        
        NavigationStack {
            if books.isEmpty {
                BookSearchEmptyView(type: $bookListViewModel.type, searchText: $searchText, isFavorite: false)
                    .navigationTitle(Constants.searchBook)
                    .navigationBarTitleDisplayMode(.large)
            } else {
                List(books) { book in
                    ZStack {
                        NavigationLink(destination:
                                        BookDescriptionView(bookItem: book)
                            .toolbarRole(.editor) // Backは非表示にする
                        ) {
                            EmptyView()
                        }
                        // NavigationLinkの右の矢印を消す
                        .opacity(0)
                        BookDetailView(bookItem: book, isFavorite: self.realmViewModel.isFavorite(id: book.id ?? ""))
                            .listRowInsets(rowInsets)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Constants.searchBook)
                .navigationBarTitleDisplayMode(.large)
            }
        }
        // API関連のアラート
        .customAlert(for: $bookListViewModel.alertViewModel.alertEntity)
        .searchable(text: $searchText, prompt: Constants.placeHolder)
        .onChange(of: searchText) { newValue in
            // 検索バーの文字列が更新された
            if newValue == "" {
                // クリアボタンがおされた
                self.focus = false
                self.bookListViewModel.cancel()
                self.bookListViewModel.type = .initial
            }
        }
        .onSubmit(of: .search) {
            // 決定キー押された
            if !self.searchText.isEmpty {
                self.focus = false
                self.bookListViewModel.resumeSearch(searchWord: self.searchText, maxResults: self.maxResults)
            }
        }
        .focused(self.$focus)
        .PKHUD(isPresented: $bookListViewModel.isFetching, HUDContent: .progress, delay: 0.0)
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
            .environmentObject(RealmViewModel())
    }
}
