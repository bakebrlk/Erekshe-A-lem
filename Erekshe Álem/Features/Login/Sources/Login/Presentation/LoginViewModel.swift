//
//  Login
//  LoginViewModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: Params
    @Published private var model: LoginModel

    // MARK: Init
    init(dependencies: Dependencies) {
        self.model = LoginModel()
    }
}

// MARK: - Dependencies
extension LoginViewModel {
    struct Dependencies {
        
        init() {
            
        }
    }
}
