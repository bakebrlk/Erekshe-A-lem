//
//  Login
//  RegistryViewModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 12.12.2025.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Combine
import PFirebase
import AuthenticationServices
import GoogleSignIn

@MainActor
final class RegistryViewModel: ObservableObject {
    // MARK: Params
    @Published private var model: RegistryModel
    let mainColor = Color(red: 119/255, green: 221/255, blue: 231/255)
    private var firebase: CFirebase = CFirebase.shared
    private weak var coordinator: RegistryCoordinator?

    // MARK: Init
    init(dependencies: Dependencies) {
        self.model = RegistryModel()
        self.coordinator = dependencies.coordinator
    }
    
    // MARK: - Modeling
    func getName() -> Binding<String> {
        Binding(
            get: { self.model.name },
            set: { self.model.name = $0 }
        )
    }
    
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
    
    func getPasswordConfirmation() -> Binding<String> {
        Binding(
            get: { self.model.passwordConfirmation },
            set: { self.model.passwordConfirmation = $0 }
        )
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
    
    // MARK: - Actions
    func signUpWithEmail() async {
        if checkValidation() {
            do {
                model.state = .loading
                try await firebase.signUpEmail(
                    email: model.email,
                    password: model.password
                )
                model.state = .display
            } catch {
                model.state = .error
            }
        }
    }
    
    private func checkValidation() -> Bool {
        if model.password == model.passwordConfirmation {
            return validateEmail(model.email).isValid
            && validatePassword(model.password).isValid
        } else {
            return false
        }
    }
}

// MARK: - Private Functions
private extension RegistryViewModel {
    func validateEmail(_ email: String) -> (isValid: Bool, errorMessage: String?) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            return (false, "Email cannot be empty")
        }
        
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else {
            return (false, "Please enter a valid email address")
        }
        
        return (true, nil)
    }

    func validatePassword(_ password: String) -> (isValid: Bool, errorMessage: String?) {
        guard !password.isEmpty else {
            return (false, "Password cannot be empty")
        }
        
        guard password.count >= 8 else {
            return (false, "Password must be at least 8 characters long")
        }
        
        let uppercaseRegex = ".*[A-Z]+.*"
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        guard uppercasePredicate.evaluate(with: password) else {
            return (false, "Password must contain at least one uppercase letter")
        }
        
        let lowercaseRegex = ".*[a-z]+.*"
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
        guard lowercasePredicate.evaluate(with: password) else {
            return (false, "Password must contain at least one lowercase letter")
        }
        
        let digitRegex = ".*[0-9]+.*"
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        guard digitPredicate.evaluate(with: password) else {
            return (false, "Password must contain at least one number")
        }
        
        return (true, nil)
    }
}

// MARK: - Dependencies
extension RegistryViewModel {
    struct Dependencies {
        var coordinator: RegistryCoordinator

        init(coordinator: RegistryCoordinator) {
            self.coordinator = coordinator
        }
    }
}
