//
//  RegistryCoordinator.swift
//  Login
//
//  Created by bakebrlk on 25.12.2025.
//

import SwiftUI
import Router
import Nivelir

public final class RegistryCoordinator: IDestinationCoordinator {
    
    public typealias Destination = LoginDestination
    
    public let navigator: ScreenNavigator
    private let dependencies: Dependencies
    
    public init(navigator: ScreenNavigator, dependencies: Dependencies = .init()) {
        self.navigator = navigator
        self.dependencies = dependencies
    }
    
    public func navigate(to destination: LoginDestination) {
        switch destination {
        case .registry:
            ()
        }
    }
    
    public func makeView() -> AnyView {
        return AnyView(RegistryView())
    }
}

extension  RegistryCoordinator {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
