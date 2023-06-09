//
//  BooksListView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct BooksListView: View {
    
    // ViewModel
    private var bookListViewModel = BookListViewModel()
    
    // UI Style
    private let rowInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    @State private var searchText: String = ""
    
    var body: some View {
        
        // Mock
        let books: [BookItem] = [
            Constants.getSampleBookItem(mockPerson: .steve_jobs),
            Constants.getSampleBookItem(mockPerson: .tim_cook),
            Constants.getSampleBookItem(mockPerson: .jony_ive)
        ]
        //let books: [BookItem] = self.bookListViewModel.repositories.items ?? []
        
        NavigationStack {
            List(books) { book in
                NavigationLink(destination: BookDescriptionView(bookItem: book)) {
                    BookDetailView(bookItem: book)
                        .listRowInsets(rowInsets)
                }
            }
            .listStyle(.plain)
            .navigationTitle("本を探す")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                // 検索バーの文字列が更新された
                if newValue == "" {
                    // クリアボタンがおされた
                    print("クリアボタン押された")
                }
            }
            .onSubmit(of: .search) {
                // 決定キー押された
            }
        }
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}
