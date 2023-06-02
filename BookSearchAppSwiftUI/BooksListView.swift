//
//  BooksListView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

struct BooksListView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Books List")
                    .font(.system(size: 38).bold())
                    .foregroundColor(.primary)
                Text("素晴らしい本たち")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
            }
            .navigationTitle("本を探す")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText)
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}
