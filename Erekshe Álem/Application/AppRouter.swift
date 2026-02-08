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

public final class AppRouter: IAppRouting {
    
    public let navigator: ScreenNavigator
    private let window: UIWindow
    private let firebase: CFirebase = CFirebase.shared
    
    public init(window: UIWindow) {
        self.window = window
        
        window.rootViewController = UINavigationController()
        window.makeKeyAndVisible()
        
        self.navigator = ScreenNavigator(window: window)
    }
    
    public func start() {
        let coordinator: ICoordinator  = firebase.isUserAuthenticated()
        ? GameCoordinator(navigator: navigator)
        : LoginCoordinator(navigator: navigator, dependencies: .init())
        
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

