//
//  EmptyView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/09.
//

import SwiftUI

struct BookSearchEmptyView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: 6) {
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Image("search-man")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .scaledToFill()
                        .clipped()
                        .background(Color.white)
                    Text("本を探せるよ！")
                        .font(Font.system(size: 20))
                        .bold()
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

struct BookSearchEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchEmptyView().previewLayout(.sizeThatFits)
    }
}
