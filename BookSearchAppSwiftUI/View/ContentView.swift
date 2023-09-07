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
                        Image(systemName: Constants.magnifyingglass_icon)
                        Text(Constants.bottom_search)
                    }
                }.tag(1)
            FavoritesListView()
                .tabItem {
                    VStack {
                        Image(systemName: Constants.star_icon)
                        Text(Constants.bottom_favorite)
                    }
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RealmViewModel())
    }
}
