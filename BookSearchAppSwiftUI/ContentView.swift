//
//  ContentView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BooksListView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("検索")
                    }
                }.tag(1)
            FavoritesListView()
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("お気に入り")
                    }
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
