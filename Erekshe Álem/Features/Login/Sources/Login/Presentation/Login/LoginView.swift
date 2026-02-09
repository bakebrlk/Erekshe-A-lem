//
//  Login
//  LoginView.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import CommonUI
import AuthenticationServices
import CommonUI

public struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    public init(dependencies: Dependencies) {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(
                dependencies: .init(coordinator: dependencies.coordinator)
            )
        )
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            switch viewModel.model.state {
            case .display: displayBody
            case .loading: splashScreen
            case .error: Text("Error!!")
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var splashScreen: some View {
        VStack(spacing: 20) {
            Image(.authSplash)
                .resizable()
                .scaledToFit()
                .frame(width: 225, height: 225)
                .scaleEffect(viewModel.model.isAnimated ? 1.0 : 0.4)
                .opacity(viewModel.model.isAnimated ? 1.0 : 0.0)
            
            Text("Erekshe Alem")
                .foregroundColor(.blue)
                .font(.system(size: 30, weight: .black))
                .opacity(viewModel.model.isAnimated ? 1.0 : 0.0)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                viewModel.model.isAnimated = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.model.state = .display
                }
            }
        }
    }
    
    private var displayBody: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 0) {
                TabView(selection: viewModel.getCurentPage()) {
                    ForEach(Array(viewModel.onBording.enumerated()), id: \.element.id) { index, data in
                        onBording(
                            textF: data.titleFirst,
                            textS: data.titleSecond,
                            textT: data.titleThird,
                            description: data.description,
                            imageName: "onBording\(data.id)"
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            
            HStack(spacing: 8) {
                ForEach(0..<viewModel.onBording.count, id: \.self) { index in
                    Circle()
                        .fill(viewModel.getCurentPage().wrappedValue == index ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.bottom, 40)
            Spacer()
            
            VStack(spacing: 16) {
                SignInWithAppleButton(
                    onRequest: { request in viewModel.signInWithAppleOnRequest(request: request) },
                    onCompletion: { result in
                        Task {
                            await viewModel.signInWithAppleOnCompletion(result: result)
                        }
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: 58)
                .cornerRadius(35)

                Button(action: {
                    Task {
                        await viewModel.signInWithGoogle()
                    }
//                    viewModel.navigateToRegistry()
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Login with Google")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }
    
    private func onBording(
        textF: String,
        textS: String,
        textT: String,
        description: String,
        imageName: String
    ) -> some View {
        VStack(spacing: 34) {
            VStack(spacing: 4) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        height: UIScreen.main.bounds.height * 0.29
                    )
                
                (Text(textF)
                    .foregroundColor(.orange)
                + Text(textS)
                    .foregroundColor(.green)
                + Text(textT)
                    .foregroundColor(.red))
                    .font(.system(size: 30, weight: .black))
                
                Text(description)
                    .font(.system(size: 21, weight: .medium))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension LoginView {
    public struct Dependencies {
        
        var coordinator: LoginCoordinator
        
        init(coordinator: LoginCoordinator) {
            self.coordinator = coordinator
        }
    }
}
