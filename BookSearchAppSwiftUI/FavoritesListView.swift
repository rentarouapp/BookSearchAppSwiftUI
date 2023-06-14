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
    
    @State var editMode: EditMode = .inactive
    
    // UI Style
    private let rowInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var body: some View {
        
        NavigationStack {
            if self.realmViewModel.booksFromData.isEmpty {
                BookSearchEmptyView()
                    .navigationTitle(Constants.favoriteList)
                    .navigationBarTitleDisplayMode(.large)
            } else {
                List {
                    ForEach(self.realmViewModel.booksFromData, id: \.id) { book in
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
                    .onDelete { (offset) in
                        // 削除ボタンが押されて削除されたときに呼ばれる
                        if let row = offset.first, let targetBookItem  = self.realmViewModel.booksFromData[safe: row] {
                            self.realmViewModel.deleteRealmBookData(bookItem: targetBookItem, withAlert: false)
                        }
                    }
                }
                .toolbar {
                    EditButton()
                }
                .environment(\.editMode, $editMode)
                .listStyle(.plain)
                .navigationTitle(Constants.favoriteList)
                .navigationBarTitleDisplayMode(.large)
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
