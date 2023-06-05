//
//  BookDetailView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct BookDetailView: View {
    
    // UI Style
    let textPadding: EdgeInsets = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
    
    var bookModel: BookModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(maxWidth: 16, maxHeight: .infinity)
                if let url = URL(string: self.bookModel.thumbImageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .clipped() // 切り取る
                    } placeholder: {
                        Image(systemName: "star")
                    }
                    .frame(maxWidth: 100, maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .cornerRadius(6) // ImageにもRadiusをつける
                }
                VStack(alignment: .leading) {
                    Text(self.bookModel.bookTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .font(Font.system(size: 17))
                        .bold()
                        .padding(self.textPadding)
                        .lineLimit(2)
                    Text(self.bookModel.authorName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .font(Font.system(size: 17))
                        .padding(self.textPadding)
                        .lineLimit(1)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
                    .frame(maxWidth: 16, maxHeight: .infinity)
            }
            .frame(width: .infinity, height: 120)
        }
        .frame(width: .infinity, height: 120)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookDetailView(bookModel: BookModel(id: 1, bookTitle: Constants.title_1, authorName: Constants.author_1, thumbImageUrl: Constants.thumbUrl_1))
        }
        .previewLayout(.sizeThatFits)
    }
}
