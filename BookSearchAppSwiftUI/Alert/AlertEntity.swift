//
//  AlertEntity.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/11.
//

import Foundation

enum AlertButtonType {
    case singleButton
    case doubleButton
    case doubleButtonDestructive
}

struct AlertEntity {
    var isShowingAlert: Bool = false
    var alertButtonType: AlertButtonType = .singleButton
    var title: String = ""
    var message: String = ""
    var positiveTitle: String = ""
    var negativeTitle: String = ""
    var buttonAction: () -> Void = {}
    
    mutating func show(alertButtonType: AlertButtonType,
                       title: String,
                       message: String,
                       positiveTitle: String,
                       negativeTitle: String,
                       buttonAction: @escaping () -> Void = {}) {
        
        self.alertButtonType = alertButtonType
        self.title = title
        self.message = message
        self.positiveTitle = positiveTitle
        self.negativeTitle = negativeTitle
        self.buttonAction = buttonAction
        self.isShowingAlert = true
    }
    
    mutating func hide() {
        self.isShowingAlert = false
    }
    
}
