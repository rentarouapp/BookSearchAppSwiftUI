//
//  BookDetailView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct BookDetailView: View {
    var bookModel: BookModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(maxWidth: 16, maxHeight: .infinity)
                    .background(Color.blue)
                if let url = URL(string: self.bookModel.thumbImageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geometry.size.height, maxHeight: .infinity)
                            .clipped() // 切り取る
                    } placeholder: {
                        Image(systemName: "star")
                    }
                    .frame(maxWidth: geometry.size.height, maxHeight: .infinity)
                    .background(Color.red)
                }
                VStack {
                    Text(self.bookModel.bookTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Text(self.bookModel.authorName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
                    .frame(maxWidth: 16, maxHeight: .infinity)
                    .background(Color.blue)
            }
            .frame(width: .infinity, height: 120)
        }
        .frame(width: .infinity, height: 120)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookDetailView(bookModel: BookModel(bookTitle: Constants.title_1, authorName: Constants.author_1, thumbImageUrl: Constants.thumbUrl_1))
            BookDetailView(bookModel: BookModel(bookTitle: Constants.title_2, authorName: Constants.author_2, thumbImageUrl: Constants.thumbUrl_2))
        }.previewLayout(.sizeThatFits)
    }
}
