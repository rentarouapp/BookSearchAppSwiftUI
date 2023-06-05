//
//  BookDescriptionView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/02.
//

import SwiftUI

struct BookDescriptionView: View {
    var bookModel: BookModel
    
    // View Constants
    private let thumbnailHeight: CGFloat = 160
    
    private let titleFontSize: CGFloat = 12
    private let titleTextHeight: CGFloat = 16
    private let contentFontSize: CGFloat = 17
    
    private let descriptionFontSize: CGFloat = 15
    
    // UI Style
    let viewInset: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    let textPadding: EdgeInsets = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
    let descriptionPadding: EdgeInsets = EdgeInsets(top: 2, leading: 6, bottom: 6, trailing: 6)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        // サムネ、右3つのテキスト
                        if let url = URL(string: self.bookModel.thumbImageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped() // 切り取る
                            } placeholder: {
                                Image(Constants.noImageIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 3, height: self.thumbnailHeight)
                            }
                            .frame(width: geometry.size.width / 3, height: self.thumbnailHeight)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .cornerRadius(6) // ImageにもRadiusをつける
                        } else {
                            Image(Constants.noImageIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 3, height: self.thumbnailHeight)
                        }
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text(Constants.title)
                                    .font(Font.system(size: self.titleFontSize))
                                    .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                Text(self.bookModel.bookTitle)
                                    .font(Font.system(size: self.contentFontSize)).bold()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            }
                            .frame(maxHeight: .infinity)
                            VStack(spacing: 0) {
                                Text(Constants.author)
                                    .font(Font.system(size: self.titleFontSize))
                                    .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                Text(self.bookModel.authorName)
                                    .font(Font.system(size: self.contentFontSize)).bold()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            }
                            .frame(maxHeight: .infinity)
                            VStack(spacing: 0) {
                                Text(Constants.releasedDate)
                                    .font(Font.system(size: self.titleFontSize))
                                    .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                Text("2023-06-05")
                                    .font(Font.system(size: self.contentFontSize)).bold()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            }
                            .frame(maxHeight: .infinity)
                        }
                        .frame(maxWidth: (.infinity))
                    }
                    .frame(height: self.thumbnailHeight)
                    
                    VStack {
                        // 説明タイトルと説明文テキストビュー
                        Text(Constants.bookDescription)
                            .font(Font.system(size: self.titleFontSize))
                            .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                            .foregroundColor(Color.gray)
                        Text(Constants.descriptionText)
                            .font(Font.system(size: self.descriptionFontSize))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .lineLimit(nil)
                            .padding(self.descriptionPadding)
                    }
                    VStack {
                        // ボタン2つ
                        Button(action: {
                            print("push add favorite")
                        }, label: {
                            Image(systemName: Constants.star)
                            Text(Constants.addFavorite)
                        })
                        .frame(width: geometry.size.width, height: 60)
                        .background(Color.yellow)
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                        
                        Button(action: {
                            print("push safari")
                        }, label: {
                            Image(systemName: Constants.safari)
                            Text(Constants.openBrowser)
                        })
                        .frame(width: geometry.size.width, height: 60)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                    }
                    
                }
            }
        }.padding(self.viewInset)
    }
}

struct BookDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        BookDescriptionView(bookModel: BookModel(id: 1, bookTitle: Constants.title_1, authorName: Constants.author_1, thumbImageUrl: Constants.thumbUrl_1))
            .previewLayout(.sizeThatFits)
    }
}
