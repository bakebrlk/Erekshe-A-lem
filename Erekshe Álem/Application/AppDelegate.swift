//
//  AppDelegate.swift
//  Erekshe Álem
//
//  Created by bakebrlk on 04.12.2025.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        if let clientID = FirebaseApp.app()?.options.clientID {
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            print("GIDSignIn configured with Client ID: \(clientID)")
        } else {
            print("Error: Could not retrieve FirebaseApp.app()?.options.clientID for GIDSignIn configuration.")
        }
        
        return true
    }
    
    // MARK: - Обработка URL для Google Sign-In
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
