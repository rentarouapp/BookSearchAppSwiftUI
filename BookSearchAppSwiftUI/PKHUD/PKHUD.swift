//
//  PKHUD.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import SwiftUI
import PKHUD

extension View {
    public func PKHUD(isPresented: Binding<Bool>, HUDContent: HUDContentType, delay: Double) -> some View {
        PKHUDViewModifier(isPresented: isPresented, HUDContent: HUDContent, delay: delay, parent: self)
    }
}
