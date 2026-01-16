//
//  Game
//  GameViewModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.01.2026.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Combine
import PFirebase

@MainActor
final class GameViewModel: ObservableObject {
    // MARK: Params
    @Published var model: GameModel
    private weak var coordinator: GameCoordinator?

    // MARK: Init
    init(dependencies: Dependencies) {
        self.model = GameModel()
        self.coordinator = dependencies.coordinator
    }
    
    // MARK: - Modeling
    func getState() -> Binding<RequestState> {
        Binding(
            get: { self.model.state },
            set: { self.model.state = $0 }
        )
    }
}

// MARK: - Dependencies
extension GameViewModel {
    struct Dependencies {
        
        var coordinator: GameCoordinator
        
        public init(
            coordinator: GameCoordinator
        ) {
            self.coordinator = coordinator
        }
    }
}
