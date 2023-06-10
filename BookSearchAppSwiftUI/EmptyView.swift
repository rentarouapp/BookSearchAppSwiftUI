//
//  EmptyView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/09.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        Image("search-man")
            .frame(width: 200, height: 200)
            .background(Color.white)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView().previewLayout(.sizeThatFits)
    }
}
