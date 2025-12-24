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

public final class AppRouter: IAppRouting {
    
    public let navigator: ScreenNavigator
    private let window: UIWindow
    
    
    public init(window: UIWindow) {
        self.window = window
        
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        navigator = ScreenNavigator(window: window)
    }
    
    public func start() {
        let loginCoordinator = LoginCoordinator(navigator: navigator, dependencies: .init())
                
        navigator.navigate { route in
            route
                .setRoot(to: loginCoordinator.asAnyScreen(), animation: .none)
                .resolve()
        }
    }
}

