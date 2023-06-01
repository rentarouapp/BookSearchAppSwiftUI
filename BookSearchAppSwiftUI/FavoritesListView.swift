//
//  FavoritesListView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct FavoritesListView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Favorites List")
                    .font(.system(size: 38).bold())
                    .foregroundColor(.primary)
                Text("お気に入りの本たち")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
            }
            .navigationTitle("お気に入り")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("編集タップ")
                    }) {
                        Text("編集")
                    }
                }
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
