//
//  Game
//  GameCoordinatorCoordinator.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.01.2026.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Router
import Nivelir
 
public final class GameCoordinator: IDestinationCoordinator {

    public typealias Destination = GameDestination
    
    public let navigator: ScreenNavigator
    private let dependencies: Dependencies
    
    
    public init(navigator: ScreenNavigator, dependencies: Dependencies = .init()) {
        self.navigator = navigator
        self.dependencies = dependencies
    }

    public func navigate(to destination: GameDestination) {
//        switch destination {
//        
//        }
    }
    
    public func makeView() -> AnyView {
        return AnyView(GameView(dependencies: .init(coordinator: self)))
    }
}

extension GameCoordinator {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
