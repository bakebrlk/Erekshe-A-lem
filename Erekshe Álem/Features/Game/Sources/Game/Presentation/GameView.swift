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
import DesignSystem
import CommonUI
import Domain

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
                        Image(.premain)
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
                        Image(.premain)
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
        .onAppear {
            Task {
                await viewModel.fetchGames()
            }
        }
    }
    
    
    private var displayBody: some View {
        ZStack {
            Image(.mainBG)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                HStack(spacing: 20) {
                    
                    HStack(spacing: 2) {
                        HStack(spacing: 5) {
                            Image(.box)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 30, maxHeight: 30)
                            
                            Text("Награды")
                                .frame(maxWidth: 80)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.blue071)
                        }
                        .padding(.horizontal, 5)
                        .background(.yellowD73)
                        .cornerRadius(20)
                    }
                    .padding(4)
                    .background(.yellowB62)
                    .cornerRadius(20)
                    
                    Spacer()
                    
                    ZStack {
                        HStack(spacing: 2) {
                            Text("100")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.system(size: 22, weight: .semibold))
                        }
                        .padding(4)
                        .background(.yellowE1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.yellow34A, lineWidth: 2)
                        )
                        .cornerRadius(20)
                        
                        Image(.coin)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 45, alignment: .leading)
                    }
                    .frame(maxWidth: 90)
                    .clipped()
                }
                .padding(30)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(viewModel.getGames()) { game in
                            cart(model: game.wrappedValue)
                        }
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.08)
                
                Spacer()
            }
            
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(.iconRight)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50, maxHeight: 50)
                    }
                    .frame(width: 90, height: 90)
                    .background(.blueFF)
                    .cornerRadius(45, corners: [.bottomLeft, .topLeft])
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private func cart(model: Game) -> some View {
        ZStack {
            VStack(spacing: .zero) {
                Spacer()
                VStack(spacing: .zero) {
                    Spacer()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: UIScreen.main.bounds.height * 0.542
                )
                .overlay(
                    RoundedCornerShape(
                        topLeft: 50,
                        topRight: 50,
                        bottomLeft: 20,
                        bottomRight: 20
                    )
                    .foregroundStyle(model.color.mainColor)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: .zero) {
                Spacer()
                VStack(spacing: 5) {
                    Text(model.title)
                        .font(.system(
                            size: 22,
                            weight: .bold
                        ))
                        .foregroundStyle(.blueE79)
                    
                    VStack(spacing: 5) {
                        Text(model.description)
                            .font(.system(
                                size: 15,
                                weight: .semibold
                            ))
                        Image(model.deLogo)
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(model.color.mainColor, lineWidth: 1)
                    )
                    
                    Button {
                        
                    } label: {
                        Text("Играть")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 10)
                    .background(.green)
                    .cornerRadius(30, corners: .allCorners)
                    .padding(.horizontal, 30)
                    .padding(.top, 5)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.495)
                .background(
                    RoundedCornerShape(
                        topLeft: 50,
                        topRight: 50,
                        bottomLeft: 20,
                        bottomRight: 20
                    )
                    .foregroundStyle(.white)
                )
                .padding(10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: .zero) {
                Image(model.logo)
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .frame(width: 55, height: 55)
                    .background(model.color.logoColor)
                    .overlay (
                        Circle()
                            .stroke(model.color.strokeColor, lineWidth: 6)
                    )
                    .cornerRadius(27.5, corners: .allCorners)
            }
            .frame(
                width: UIScreen.main.bounds.width * 0.252,
                height: UIScreen.main.bounds.height * 0.618,
                alignment: .top
            )
        }
        .frame(
            width: UIScreen.main.bounds.width * 0.252,
            height: UIScreen.main.bounds.height * 0.618
        )
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
