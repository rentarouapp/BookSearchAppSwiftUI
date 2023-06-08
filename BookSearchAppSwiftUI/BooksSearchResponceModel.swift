//
//  BooksSearchResponceModel.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/08.
//

import Foundation

//全てのデータの構造
struct BooksSearchResponse: Codable {
    let items: [BookItem]?
}

//Items内のデータ構造
struct BookItem: Codable, Identifiable {
    let id: String?
    let volumeInfo: VolumeInfo?
}

//VolumeInfo内のデータ構造
struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let imageLinks: ImageLinks?
    let infoLink: String?
    let publishedDate: String?
    let description: String?
}

//ImageLinks内のデータ構造
struct ImageLinks: Codable {
    let thumbnail: String?
    let smallThumbnail: String?
}

