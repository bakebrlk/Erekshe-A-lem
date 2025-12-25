//
//  Login
//  RegistryView.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 12.12.2025.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import AuthenticationServices

public struct RegistryView: View {
    
    @StateObject var viewModel: RegistryViewModel
    
    public init(dependencies: Dependencies) {
        print("Registry View Init !!!")
        _viewModel = StateObject(
            wrappedValue: RegistryViewModel(
                dependencies: .init(coordinator: dependencies.coordinator)
            )
        )
    }

    public var body: some View {
        displayBody
    }

    private var displayBody: some View {
        VStack(spacing: 24) {
            Text("Create Account")
                .font(.largeTitle.bold())
                .foregroundColor(viewModel.mainColor)
            
            Spacer()
            
            VStack(spacing: 16) {
                TextField("Full Name", text: viewModel.getName())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                
                TextField("Email", text: viewModel.getEmail())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: viewModel.getPassword())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                
                SecureField("Confirm Password", text: viewModel.getPasswordConfirmation())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            
            Button(action: {
                Task {
                    await viewModel.signUpWithEmail()
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.mainColor)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            VStack(spacing: 16) {
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    Text("or continue with")
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                }
                .padding(.horizontal, 24)
                
                SignInWithAppleButton(
                    .signUp,
                    onRequest: { request in viewModel.signInWithAppleOnRequest(request: request) },
                    onCompletion: { result in
                        Task {
                            await viewModel.signInWithAppleOnCompletion(result: result)
                        }
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: 52)
                .padding(.horizontal, 24)
                
                Button(action: {
                    Task {
                        await viewModel.signInWithGoogle()
                    }
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Sign up with Google")
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
                
                Button(action: {
//                    viewModel.navigateToLogin()
                }) {
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Text("Login")
                            .foregroundColor(viewModel.mainColor)
                            .fontWeight(.semibold)
                    }
                    .font(.callout)
                }
            }
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }

}

extension RegistryView {
    public struct Dependencies {
        var coordinator: RegistryCoordinator

        init(coordinator: RegistryCoordinator) {
            self.coordinator = coordinator
        }
    }
}
