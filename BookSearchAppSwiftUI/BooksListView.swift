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
    
    // UI Style
    private let rowInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    // test
    private var isMock = false
    
    var body: some View {
        
        // Mock or Production
        let books: [BookItem] = isMock ? [
            Constants.getSampleBookItem(mockPerson: .steve_jobs),
            Constants.getSampleBookItem(mockPerson: .tim_cook),
            Constants.getSampleBookItem(mockPerson: .jony_ive)
        ] : self.bookListViewModel.booksSearchResponse.items ?? []
        
        NavigationStack {
            if books.isEmpty {
                EmptyView()
                    .navigationTitle("本を探す")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List(books) { book in
                    NavigationLink(destination: BookDescriptionView(bookItem: book)) {
                        BookDetailView(bookItem: book)
                            .listRowInsets(rowInsets)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("本を探す")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            // 検索バーの文字列が更新された
            if newValue == "" {
                // クリアボタンがおされた
                self.focus = false
            }
        }
        .onSubmit(of: .search) {
            // 決定キー押された
            if !self.searchText.isEmpty {
                self.focus = false
                self.bookListViewModel.resumeSearch(searchWord: self.searchText)
            }
        }
        .focused(self.$focus)
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}
