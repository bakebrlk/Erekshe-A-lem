//
//  Erekshe_A_lemApp.swift
//  Erekshe Álem
//
//  Created by bakebrlk on 07.11.2025.
//

import SwiftUI
import Login

@main
struct Erekshe_A_lemApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LoginCoordinator(dependencies: .init())
        }
    }
}
