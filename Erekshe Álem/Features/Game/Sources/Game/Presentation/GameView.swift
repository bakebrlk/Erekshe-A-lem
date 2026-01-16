//
//  Game
//  GameView.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.01.2026.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Lottie

public struct GameView: View {
    
    @StateObject var viewModel: GameViewModel
    
    public init(dependencies: Dependencies) {
        _viewModel = StateObject(
            wrappedValue: GameViewModel(
                dependencies: GameViewModel.Dependencies(coordinator: dependencies.coordinator)
            )
        )
    }

    public var body: some View {
        switch viewModel.model.state {
            case .loading: loadingView
            case .display: displayBody
            case .error: Text("")
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            LottieView(animation: .named("rotateScreen"))
                .playing()
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 0.5,
                    maxHeight: UIScreen.main.bounds.height * 0.5
                )
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("premain")
                .resizable()
                .scaledToFit()
        )
        .ignoresSafeArea(.all)
    }

    private var displayBody: some View {
        Text("Hello World!")
    }

}

extension GameView {
    public struct Dependencies {
        
        var coordinator: GameCoordinator
        
        public init(
            coordinator: GameCoordinator
        ) {
            self.coordinator = coordinator
        }
    }
}
