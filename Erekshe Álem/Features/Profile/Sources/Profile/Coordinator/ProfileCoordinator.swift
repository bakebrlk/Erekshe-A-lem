//
//  Profile
//  ProfileCoordinatorCoordinator.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.02.2026.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Router
import Nivelir
import Login

public final class ProfileCoordinator: IDestinationCoordinator {

    public typealias Destination = ProfileDestination
    
    public let navigator: ScreenNavigator
    private let dependencies: Dependencies
    
    
    public init(navigator: ScreenNavigator, dependencies: Dependencies = .init()) {
        self.navigator = navigator
        self.dependencies = dependencies
    }

    public func navigate(to destination: ProfileDestination) {
        switch destination {
        case .signOut: navigateToLogin()
        }
    }
    
    private func navigateToLogin() {
        let coordinator = LoginCoordinator(navigator: navigator)
        
        navigator.navigate { route in
            route
                .top(.stack)
                .push(coordinator.asAnyScreen())
                .resolve()
        }
    }
    
    public func makeView() -> AnyView {
        return AnyView(ProfileView(dependencies: .init(coordinator: self)))
    }
}

extension ProfileCoordinator {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
