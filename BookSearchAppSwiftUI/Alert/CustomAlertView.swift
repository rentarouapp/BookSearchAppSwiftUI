//
//  CustomAlertView.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/11.
//

import SwiftUI

struct CustomAlertView: ViewModifier {
    
    @Binding var alertEntity: AlertEntity
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $alertEntity.isShowingAlert) {
                switch alertEntity.alertType {
                case .singleButton:
                    return Alert(title: Text(alertEntity.title),
                                 message: Text(alertEntity.message),
                                 dismissButton: .default(Text(alertEntity.negativeTitle), action: { alertEntity.buttonAction() })
                    )
                    
                case .doubleButton:
                    return Alert(title: Text(alertEntity.title),
                                 message: Text(alertEntity.message),
                                 primaryButton: .cancel(Text(alertEntity.positiveTitle)),
                                 secondaryButton: .default(Text(alertEntity.negativeTitle), action: { alertEntity.buttonAction() })
                    )
                case .doubleButtonDestructive:
                    return Alert(title: Text(alertEntity.title),
                                 message: Text(alertEntity.message),
                                 primaryButton: .default(Text(alertEntity.positiveTitle)),
                                 secondaryButton: .destructive(Text(alertEntity.negativeTitle), action: { alertEntity.buttonAction() })
                    )
                }
            }
    }
    
}
