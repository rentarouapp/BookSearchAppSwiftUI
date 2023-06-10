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
    
    var bookItem: BookItem
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                if let urlStr = self.bookItem.volumeInfo?.imageLinks?.smallThumbnail, let url = URL(string: urlStr) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped() // 切り取る
                    } placeholder: {
                        Image(Constants.noImageIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .cornerRadius(6) // ImageにもRadiusをつける
                } else {
                    Image(Constants.noImageIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .cornerRadius(6) // ImageにもRadiusをつける
                }
                VStack(alignment: .leading) {
                    Text(self.bookItem.volumeInfo?.title ?? "")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .font(Font.system(size: 17))
                        .bold()
                        .padding(self.textPadding)
                        .lineLimit(2)
                    Text(self.bookItem.volumeInfo?.authors?.first ?? "")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .font(Font.system(size: 17))
                        .padding(self.textPadding)
                        .lineLimit(1)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: .infinity, height: 120)
        }
        .frame(width: .infinity, height: 120)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookDetailView(bookItem: Constants.getSampleBookItem(mockPerson: .steve_jobs))
        }
        .previewLayout(.sizeThatFits)
    }
}
