//
//  Login
//  LoginView.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI

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
        displayBody
    }

    private var displayBody: some View {
        Text("Hello World!")
    }

}

extension LoginView {
    public struct Dependencies {
        
        public init(
            
        ) {
            
        }
    }
}
