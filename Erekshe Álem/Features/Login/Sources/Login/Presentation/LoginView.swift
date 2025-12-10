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

public struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    public init() {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(
                dependencies: LoginViewModel.Dependencies()
            )
        )
    }
    
    public var body: some View {
        switch viewModel.model.state {
            case .display: displayBody
            case .loading: LoadingView()
            case .error: Text("Error!!")
        }
    }
    
    private var displayBody: some View {
        VStack(spacing: 24) {
            Text("Welcome Back")
                .font(.largeTitle.bold())
                .foregroundColor(viewModel.mainColor)
            
            Spacer()
            
            VStack(spacing: 16) {
                TextField("Email", text: viewModel.getEmail())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                
                
                SecureField("Password", text: viewModel.getPassword())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            
            
            Button(action: viewModel.signWithEmail) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.mainColor)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 24)
            
            
            Button(action: {}) {
                Text("Forgot password?")
                    .foregroundColor(viewModel.mainColor)
                    .font(.callout)
            }
            .padding(.top, -8)
            
            Spacer()

            VStack(spacing: 16) {
                SignInWithAppleButton(
                    onRequest: { request in viewModel.signInWithAppleOnRequest(request: request) },
                    onCompletion: { result in viewModel.signInWithAppleOnCompletion(result: result) }
                )
                .frame(maxWidth: .infinity, maxHeight: 52)
                .padding(.horizontal, 24)
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Login with Google")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 24)
                
                Button(action: {}) {
                    Text("Create new account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.mainColor)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)
            }
            
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }
    
}

extension LoginView {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
