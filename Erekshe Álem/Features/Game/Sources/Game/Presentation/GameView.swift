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
        GeometryReader { geo in
            VStack {
                Spacer()
                
                if viewModel.model.canForceUpdate {
                    Text(viewModel.model.loadingText)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .red, .green],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .onAppear {
                            viewModel.loadingTextTypeWriter()
                        }
                } else {
                    LottieView(animation: .named("rotateScreen"))
                        .playing()
                        .animationDidFinish { _ in
                            viewModel.rotate(.landscape)
                            viewModel.model.canForceUpdate = true
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
                    if viewModel.model.canForceUpdate {
                        Image("premain")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geo.size.height,
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
        ZStack {
            Image("mainBG")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: .zero) {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
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
