//
//  PKHUDView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/10.
//

import SwiftUI
import PKHUD

struct PKHUDView: UIViewRepresentable {
    
    @Binding var isPresented: Bool
    var HUDContent: HUDContentType
    var delay: Double
    
    func makeUIView(context: UIViewRepresentableContext<PKHUDView>) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PKHUDView>) {
        if isPresented {
            HUD.show(HUDContent)
        } else {
            HUD.hide()
        }
        
    }
    
}
