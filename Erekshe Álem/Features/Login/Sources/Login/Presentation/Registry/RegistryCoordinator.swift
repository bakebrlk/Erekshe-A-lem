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
        print("Registry Coordinator Init !!!")
        self.navigator = navigator
        self.dependencies = dependencies
    }
    
    public func navigate(to destination: LoginDestination) {
        switch destination {
            case .registry: ()
            case .game: ()
        }
    }
    
    public func makeView() -> AnyView {
        print("Registry Coordinator make View !!!")
        return AnyView(RegistryView(dependencies: .init(coordinator: self)))
    }
}

extension  RegistryCoordinator {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
