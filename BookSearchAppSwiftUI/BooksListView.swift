//
//  BooksListView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct BooksListView: View {
    
    // UI Style
    private let rowInsets: EdgeInsets = EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
    
    @State private var searchText: String = ""
    
    var books: [BookModel] = [
        BookModel(id: 1, bookTitle: Constants.title_1, authorName: Constants.author_1, thumbImageUrl: Constants.thumbUrl_1),
        BookModel(id: 2, bookTitle: Constants.title_2, authorName: Constants.author_2, thumbImageUrl: Constants.thumbUrl_2),
        BookModel(id: 3, bookTitle: Constants.title_3, authorName: Constants.author_3, thumbImageUrl: Constants.thumbUrl_3)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                List(books) { book in
                    BookDetailView(bookModel: book)
                        .listRowInsets(rowInsets)
                }
                .listStyle(.plain)
            }
            .navigationTitle("本を探す")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
        }
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}
