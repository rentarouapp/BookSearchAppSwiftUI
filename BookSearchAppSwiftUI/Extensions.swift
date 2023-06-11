//
//  Extensions.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/11.
//

import SwiftUI

extension View {
    // アラート表示のカスタムボタン
    func customAlert(for alertEntity: Binding<AlertEntity>) -> some View {
        modifier(CustomAlertView(alertEntity: alertEntity))
    }
}
