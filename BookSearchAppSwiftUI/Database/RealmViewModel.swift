//
//  RealmViewModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import Foundation
import RealmSwift

class RealmViewModel: ObservableObject {
    
    // Model
    @Published var model: RealmBookModel = RealmBookModel()
    // Alert
    @Published var alertViewModel = AlertViewModel()
    // BookData
    @Published var booksFromData: [BookItem] = []
    
    // DBに書き込み中かどうか
    var isWorking: Bool {
        self.model.isWorking
    }
    
    init() {
        self.booksFromData = self.model.realmBookDatas
    }
    
    // ViewからのリクエストでモデルをRealmに登録する
    func addRealmBookData(bookItem: BookItem) {
        // 変更することを明示
        self.objectWillChange.send()
        // Modelに依頼
        self.model.addRealmBookData(bookItem: bookItem, completion: { [weak self] in
            guard let `self` = self else { return }
            self.objectWillChange.send()
            self.booksFromData = self.model.realmBookDatas
            // 登録完了
            self.alertViewModel.alertEntity.show(alertButtonType: .singleButton,
                                                 title: Constants.realmDone,
                                                 message: Constants.realmDoneMessage,
                                                 negativeTitle: Constants.commonCloseButton)
        })
    }
    
    // Viewからのリクエストでモデルをお気に入りから削除する
    func deleteRealmBookData(bookItem: BookItem, withAlert: Bool) {
        // 変更することを明示
        self.objectWillChange.send()
        // Modelに依頼
        self.model.deleteRealmBookData(bookItem: bookItem, completion: { [weak self] in
            // 削除完了
            guard let `self` = self else { return }
            self.objectWillChange.send()
            self.booksFromData = self.model.realmBookDatas
            if withAlert {
                // 仕様のバグ？こうしないと即時で呼ばれない
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
                    guard let `self` = self else { return }
                    self.objectWillChange.send()
                    self.alertViewModel.alertEntity.show(alertButtonType: .singleButton,
                                                         title: Constants.realmDeleteDone,
                                                         message: Constants.realmDeleteDoneMessage,
                                                         negativeTitle: Constants.commonCloseButton)
                })
            }
        })
    }
    
    // Viewから受けとったbookItemがお気に入りに登録されていたらtrue
    func isFavorite(id: String) -> Bool {
        return self.model.isFavorite(id: id)
    }
    
    
}
