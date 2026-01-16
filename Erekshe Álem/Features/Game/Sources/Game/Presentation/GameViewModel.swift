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
import CommonUI

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
    
    // MARK: - Action
    func rotate(_ orientation: UIInterfaceOrientationMask) {
        OrientationLock.lock = orientation
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let preferences = UIWindowScene.GeometryPreferences.iOS(
            interfaceOrientations: orientation
        )
        
        scene.requestGeometryUpdate(preferences) { error in
            print("Rotation error:", error.localizedDescription)
        }
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
