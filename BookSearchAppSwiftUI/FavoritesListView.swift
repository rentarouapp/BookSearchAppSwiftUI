//
//  FavoritesListView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct FavoritesListView: View {
    
    // ViewModel
    private var bookListViewModel = BookListViewModel()
    
    // Realm
    @EnvironmentObject var realmViewModel: RealmViewModel
    
    // UI Style
    private let rowInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var body: some View {
        
        let books: [BookItem] = self.realmViewModel.booksFromData
        
        NavigationStack {
            if books.isEmpty {
                BookSearchEmptyView()
                    .navigationTitle(Constants.favoriteList)
                    .navigationBarTitleDisplayMode(.inline)
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
                        BookDetailView(bookItem: book, isFavorite: true)
                            .listRowInsets(rowInsets)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Constants.favoriteList)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("編集タップ")
                            // テストでRealmから読み出す
                            print("realmCount: \(self.realmViewModel.model.items?.count ?? 0)")
                            //self.bookListViewModel.resumeSearch(searchWord: "あああ")
                        }) {
                            Text("編集")
                        }
                    }
                }
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
            .environmentObject(RealmViewModel())
    }
}
