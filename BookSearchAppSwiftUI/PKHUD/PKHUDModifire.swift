//
//  PKHUDModifire.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import SwiftUI
import PKHUD

struct PKHUDViewModifier<Parent: View>: View {
    
    @Binding var isPresented: Bool
    var HUDContent: HUDContentType
    var delay: Double
    var parent: Parent
    
    var body: some View {
        ZStack {
            parent
            if isPresented {
                PKHUDView(isPresented: $isPresented, HUDContent: HUDContent, delay: delay)
            }
        }
    }
    
}
