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
import PFirebase

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: Params
    @Published private var model: LoginModel
    private var firebase: CFirebase = CFirebase()
    let mainColor = Color(red: 119/255, green: 221/255, blue: 231/255)
    
    // MARK: Init
    init(dependencies: Dependencies) {
        self.model = LoginModel()
    }
    
    // MARK: - Modeling
    func getEmail() -> Binding<String> {
        Binding(
            get: { self.model.email },
            set: { self.model.email = $0 }
        )
    }
    
    func getPassword() -> Binding<String> {
        Binding(
            get: { self.model.password },
            set: { self.model.password = $0 }
        )
    }
    
    // MARK: - Action
    func signWithEmail() {
        firebase.signInWithEmail(
            email: model.email,
            password: model.password) { result in
                switch result {
                case .success(_):
                    print("Good Bro!")
                case .failure(let failure):
                    print("Fail Bro:", failure.localizedDescription)
                }
            }

    }
}

// MARK: - Dependencies
extension LoginViewModel {
    struct Dependencies {
        
        init() {
            
        }
    }
}
