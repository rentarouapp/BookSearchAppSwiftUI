//
//  RealmBookData.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import Foundation
import RealmSwift

class RealmBookData: Object, Identifiable {
    @Persisted(primaryKey: true) var bookId: String
    @Persisted var title: String
    @Persisted var authors: String
    @Persisted var smallImageUrl: String
    @Persisted var largeImageUrl: String
    @Persisted var infoUrl: String
    @Persisted var publishedDate: String
    @Persisted var textDescription: String
}
