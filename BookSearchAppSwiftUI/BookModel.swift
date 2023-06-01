//
//  BookModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import Foundation

struct BookModel: Identifiable {
    var id: ObjectIdentifier
    var bookTitle: String
    var authorName: String
    var thumbImageUrl: String
}

