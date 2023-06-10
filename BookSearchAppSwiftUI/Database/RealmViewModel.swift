//
//  RealmViewModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import Foundation
import RealmSwift

class RealmViewModel: ObservableObject {
    
    @Published var model: RealmBookModel = RealmBookModel()
    
    // DBに書き込み中かどうか
    var isWorking: Bool {
        self.model.isWorking
    }
    
    // Modelから受け取ったBookItemをViewにわたす
    var booksFromData: [BookItem] {
        self.model.realmBookDatas
    }
    
    // ViewからのリクエストでモデルをRealmに登録する
    func addRealmBookData(bookItem: BookItem) {
        // 変更することを明示
        self.objectWillChange.send()
        // Modelに依頼
        self.model.addRealmBookData(bookItem: bookItem)
    }
    
    // Viewからのリクエストでモデルをお気に入りから削除する
    func deleteRealmBookData(bookItem: BookItem) {
        self.model.deleteRealmBookData(bookItem: bookItem)
    }
    
    // Viewから受けとったbookItemがお気に入りに登録されていたらtrue
    func isFavorite(id: String) -> Bool {
        return self.model.isFavorite(id: id)
    }
    
    
}
