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
    @State var canForceUpdate: Bool = false
    
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
        GeometryReader { geo in
            VStack {
                Spacer()
                
                if canForceUpdate {
                    Text("Hello World!")
                } else {
                    LottieView(animation: .named("rotateScreen"))
                        .playing()
                        .animationDidFinish { _ in
                            viewModel.rotate(.landscape)
                            canForceUpdate = true
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: UIScreen.main.bounds.height * 0.2
                        )
                }
                
                Spacer()
            }
            .frame(
                width: geo.size.width,
                height: geo.size.height
            )
            .background(
                Group {
                    if canForceUpdate {
                        Image("premain")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geo.size.height,  // Меняем местами
                                height: geo.size.width
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )
                            .clipped()
                    } else {
                        Image("premain")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )
                            .clipped()
                    }
                }
            )
        }
        .ignoresSafeArea()
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
