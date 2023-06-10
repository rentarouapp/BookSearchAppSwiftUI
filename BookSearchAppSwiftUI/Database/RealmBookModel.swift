//
//  RealmBookModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import Foundation
import RealmSwift

class RealmBookModel: ObservableObject {
    
    @Published var isWorking: Bool = false
    
    var config = Realm.Configuration()
    
    var realm: Realm? {
        do {
            let realm = try Realm(configuration: config)
            return realm
        } catch {
            return nil
        }
    }
    
    // 保存されているRealmBookDataをResult<RealmBookData>で抽出して[BookItem]にして返す
    var realmBookDatas: [BookItem] {
        if let realm = self.realm {
            let allObjects = realm.objects(RealmBookData.self)
            return self.generateBookItems(fromResults: allObjects)
        }
        return []
    }
    
    var items: Results<RealmBookData>? {
        if let realm = self.realm {
            return realm.objects(RealmBookData.self)
        }
        return nil
    }
    
    // BookItemのオブジェクトを受け取ってRealmに登録する
    func addRealmBookData(bookItem: BookItem) {
        guard let realm = self.realm else { return }
        let realmBookData = self.convertRealmBookData(fromBookItem: bookItem)
        do {
            try realm.write {
                realm.add(realmBookData)
            }
        } catch {
            print("書き込み失敗")
        }
    }
    
    // BookItemのオブジェクトを受け取ってRealmから削除する
    func deleteRealmBookData(bookItem: BookItem) {
        guard let realm = self.realm, let id = bookItem.id else { return }
        let targetBookData = realm.objects(RealmBookData.self).where({ $0.bookId == id })
        do {
            try realm.write {
                realm.delete(targetBookData)
            }
        } catch {
            print("削除失敗")
        }
    }
    
    // idに紐づくお気に入りデータあるか判定してBoolを返す
    func isFavorite(id: String) -> Bool {
        guard let realm = self.realm else { return false }
        let targetBookDatas = realm.objects(RealmBookData.self).where({ $0.bookId == id })
        return !targetBookDatas.isEmpty
    }
    
    
    // MARK: - Helper
    
    // Realmに保存されている型からBookItemに変換して返す
    func generateBookItems(fromResults results: Results<RealmBookData>) -> [BookItem] {
        var bookItems: [BookItem] = []
        results.forEach {
            let imageLink = ImageLinks(thumbnail: $0.largeImageUrl, smallThumbnail: $0.smallImageUrl)
            let volumeInfo = VolumeInfo(title: $0.title, authors: $0.authors.components(separatedBy: ","), imageLinks: imageLink, infoLink: $0.infoUrl, publishedDate: $0.publishedDate, description: $0.textDescription)
            let bookItem: BookItem = BookItem(id: $0.bookId, volumeInfo: volumeInfo)
            bookItems.append(bookItem)
        }
        return bookItems
    }
    
    // BookItemの型からRealmに保存できる型に変換して返す
    private func convertRealmBookData(fromBookItem bookItem : BookItem) -> RealmBookData {
        let realmBookData = RealmBookData()
        realmBookData.bookId = bookItem.id ?? ""
        realmBookData.title = bookItem.volumeInfo?.title ?? ""
        let authors = bookItem.volumeInfo?.authors?.joined(separator: ",")
        realmBookData.authors = authors ?? ""
        realmBookData.smallImageUrl = bookItem.volumeInfo?.imageLinks?.smallThumbnail ?? ""
        realmBookData.largeImageUrl = bookItem.volumeInfo?.imageLinks?.thumbnail ?? ""
        realmBookData.infoUrl = bookItem.volumeInfo?.infoLink ?? ""
        realmBookData.publishedDate = bookItem.volumeInfo?.publishedDate ?? ""
        realmBookData.textDescription = bookItem.volumeInfo?.description ?? ""
        return realmBookData
    }
    
}
