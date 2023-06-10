//
//  BookDescriptionView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/02.
//

import SwiftUI

struct BookDescriptionView: View {
    var bookItem: BookItem
    
    // View Constants
    private let thumbnailHeight: CGFloat = 160
    
    private let titleFontSize: CGFloat = 12
    private let titleTextHeight: CGFloat = 16
    private let contentFontSize: CGFloat = 17
    
    private let descriptionFontSize: CGFloat = 15
    
    // Realm
    @EnvironmentObject var realmViewModel: RealmViewModel
    
    // UI Style
    let viewInset: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    let textPadding: EdgeInsets = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
    let descriptionPadding: EdgeInsets = EdgeInsets(top: 2, leading: 6, bottom: 6, trailing: 6)
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        Spacer().frame(height: 16)
                        HStack(spacing: 20) {
                            // サムネ、右3つのテキスト
                            if let urlStr = bookItem.volumeInfo?.imageLinks?.smallThumbnail, let url = URL(string: urlStr) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipped() // 切り取る
                                } placeholder: {
                                    Image(Constants.noImageIcon)
                                        .resizable()
                                        .scaledToFill()
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
                                    .scaledToFill()
                                    .frame(width: geometry.size.width / 3, height: self.thumbnailHeight)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                                    .cornerRadius(6) // ImageにもRadiusをつける
                            }
                            VStack(spacing: 0) {
                                VStack(spacing: 0) {
                                    Text(Constants.title)
                                        .font(Font.system(size: self.titleFontSize))
                                        .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                                        .foregroundColor(Color.gray)
                                    Text(self.bookItem.volumeInfo?.title ?? "")
                                        .font(Font.system(size: self.contentFontSize)).bold()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                }
                                .frame(maxHeight: .infinity)
                                VStack(spacing: 0) {
                                    Text(Constants.author)
                                        .font(Font.system(size: self.titleFontSize))
                                        .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                                        .foregroundColor(Color.gray)
                                    Text(self.bookItem.volumeInfo?.authors?.first ?? Constants.nonAuthor)
                                        .font(Font.system(size: self.contentFontSize)).bold()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                }
                                .frame(maxHeight: .infinity)
                                VStack(spacing: 0) {
                                    Text(Constants.releasedDate)
                                        .font(Font.system(size: self.titleFontSize))
                                        .frame(maxWidth: .infinity, maxHeight: self.titleTextHeight, alignment: .leading)
                                        .foregroundColor(Color.gray)
                                    Text(self.bookItem.volumeInfo?.publishedDate ?? Constants.nonPublishedDate)
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
                            Text(self.bookItem.volumeInfo?.description ?? Constants.nonDescription)
                                .font(Font.system(size: self.descriptionFontSize))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .lineLimit(nil)
                                .padding(self.descriptionPadding)
                        }
                        VStack(spacing: 10) {
                            // お気に入りに登録、お気に入りから消す
                            let isFavorite = self.realmViewModel.isFavorite(id: self.bookItem.id ?? "")
                            
                            Button(action: {
                                if isFavorite {
                                    // お気に入りに登録されていたらお気に入りから削除する
                                    self.realmViewModel.deleteRealmBookData(bookItem: self.bookItem)
                                } else {
                                    // お気に入り登録がなければお気に入りとしてRealmに保存する
                                    self.realmViewModel.addRealmBookData(bookItem: self.bookItem)
                                }
                                
                            }, label: {
                                Image(systemName: isFavorite ? Constants.trash : Constants.star)
                                Text(isFavorite ? Constants.removeFavorite : Constants.addFavorite)
                            })
                            .frame(width: geometry.size.width, height: 60)
                            .background(isFavorite ? Color.white : Color.yellow)
                            .foregroundColor(isFavorite ? Color.yellow : Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.yellow, lineWidth: 2)
                            )
                            .cornerRadius(6)
                            
                            // ブラウザで開く
                            Button(action: {
                                if let urlStr = self.bookItem.volumeInfo?.infoLink,
                                   let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url){
                                    UIApplication.shared.open(url)
                                }
                            }, label: {
                                Image(systemName: Constants.safari)
                                Text(Constants.openBrowser)
                            })
                            .frame(width: geometry.size.width, height: 60)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(6)
                        }
                        Spacer().frame(height: 16)
                    }
                }
            }.padding(self.viewInset)
        }
        .navigationTitle(self.bookItem.volumeInfo?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookDescriptionView(bookItem: Constants.getSampleBookItem(mockPerson: .steve_jobs))
                .environmentObject(RealmViewModel())
        }
    }
}
