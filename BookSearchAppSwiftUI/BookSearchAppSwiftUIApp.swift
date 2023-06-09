//
//  BookSearchAppSwiftUIApp.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/01.
//

import SwiftUI

@main
struct BookSearchAppSwiftUIApp: App {
    @StateObject var realmViewModel = RealmViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(realmViewModel)
        }
    }
}
