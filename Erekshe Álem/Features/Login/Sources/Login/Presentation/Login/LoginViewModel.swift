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
import AuthenticationServices
import GoogleSignIn

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: Params
    @Published public var model: LoginModel
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
    func signWithEmail() async {
        do {
            model.state = .loading
            try await firebase.signInWithEmail(
                email: model.email,
                password: model.password
            )
            model.state = .display
        } catch {
            model.state = .error
        }
    }
    
    // MARK: - Sign in with Apple functions
    func signInWithAppleOnRequest(request: ASAuthorizationAppleIDRequest) {
        let nonce = firebase.generateAppleSignInNonce()
        model.currentNonce = nonce
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = firebase.hashAppleSignInNonceSHA256(nonce)
    }
    
    func signInWithAppleOnCompletion(result: Result<ASAuthorization, any Error>) async {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = model.currentNonce else {
                    fatalError("Неверное состояние: получен обратный вызов входа, но запрос на вход не был отправлен.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Не удалось получить токен идентификации Apple.")
                    return
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Не удалось преобразовать токен в строку.")
                    return
                }
                
                do {
                    try await firebase.signInWithApple(
                        idToken: idTokenString,
                        rawNonce: nonce,
                        fullName: appleIDCredential.fullName
                    )
                } catch {
                    model.state = .error
                }
            }
            
        case .failure(let error):
            print("❌ Ошибка при входе через Apple: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Sign in with Google functions
    func signInWithGoogle() async {
        model.state = .loading
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first?.rootViewController else {
            print("Could not find presenting view controller for Google Sign-In.")
            model.state = .error
            return
        }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
            
            guard let idToken = result.user.idToken?.tokenString else {
                print("Не удалось получить ID токен Google.")
                model.state = .error
                return
            }
            
            let accessToken = result.user.accessToken.tokenString
            
            try await firebase.signInWithGoogle(idToken: idToken, accessToken: accessToken)
            
            model.state = .display
            print("🎉 Успешный вход через Google в Firebase!")
        } catch {
            print("❌ Ошибка при входе через Google: \(error.localizedDescription)")
            model.state = .error
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
