//
//  Login
//  LoginCoordinatorCoordinator.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Router
import Nivelir

public final class LoginCoordinator: IDestinationCoordinator {
    
    public typealias Destination = LoginDestination
    
    public let navigator: ScreenNavigator
    private let dependencies: Dependencies
    
    public init(navigator: ScreenNavigator, dependencies: Dependencies = .init()) {
        self.navigator = navigator
        self.dependencies = dependencies
    }
    
    public func navigate(to destination: LoginDestination) {
        switch destination {
            case .registry: navigateToRegistry()
            case .app: navigateToApp()
        }
    }
    
    public func makeView() -> AnyView {
        return AnyView(LoginView(dependencies: .init(coordinator: self)))
    }
    
    private func navigateToRegistry() {
        let registry = RegistryCoordinator(navigator: navigator)
        
        navigator.navigate { route in
            route
                .top(.stack)
                .push(registry.asAnyScreen())
                .resolve()
        }
    }
    private func navigateToApp() {        
        navigator.navigate { route in
            route
                .top(.stack)
                .popToRoot()
                .resolve()
        }
    }
}

extension LoginCoordinator {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
