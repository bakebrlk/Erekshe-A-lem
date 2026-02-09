//
//  AppRouter.swift
//  Erekshe Álem
//
//  Created by bakebrlk on 24.12.2025.
//

import UIKit
import Nivelir
import Router
import Login
import Game
import PFirebase
import SwiftUI

public final class AppRouter: IAppRouting {
    
    public let navigator: ScreenNavigator
    private let window: UIWindow
    private let firebase: CFirebase

    public init(window: UIWindow) {
        self.window = window
        self.firebase = CFirebase.shared
        
        window.rootViewController = UINavigationController()
        window.makeKeyAndVisible()
        
        self.navigator = ScreenNavigator(window: window)
    }
    
    public func start() {
        let coordinator: ICoordinator = AppCoordinator(navigator: navigator)
        
        navigator.navigate { route in
            route
                .setRoot(
                    to: coordinator.asAnyScreen().withStackContainer(),
                    animation: .none
                )
                .makeKeyAndVisible()
                .resolve()
        }
    }
}
