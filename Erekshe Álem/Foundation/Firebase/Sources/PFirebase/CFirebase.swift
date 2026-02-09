//
//  Firebase
//  Firebase.swift
//
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import Foundation
import AuthenticationServices
import Domain
import SwiftUI

public final class CFirebase: ObservableObject, @unchecked Sendable {
    // MARK: - Params
    @ObservedObject public static var shared: CFirebase = .init()
    private let auth: CFirebaseAuth = CFirebaseAuth()
    private let fireStore: CFireStore = CFireStore()
    @Published public var loggedIn: Bool = false

    private init() {
        self.loggedIn = auth.isUserAuthenticated()
    }
    
    
    // MARK: - Auth Functions
    public func signInWithEmail(
        email: String,
        password: String
    ) async throws {
        try await auth.signInWithEmail(email: email, password: password)
    }
    
    public func signInWithApple(
        idToken: String,
        rawNonce: String,
        fullName: PersonNameComponents?
    ) async throws {
        try await auth.signInWithApple(
            idToken: idToken,
            rawNonce: rawNonce,
            fullName: fullName
        )
    }
    
    public func signInWithGoogle(
        idToken: String,
        accessToken: String
    ) async throws {
        try await auth.signInWithGoogle(idToken: idToken, accessToken: accessToken)
    }
    
//    - Registry
    public func signUpEmail(email: String, password: String) async throws {
        try await auth.signUpEmail(email: email, password: password)
    }
    
    public func isUserAuthenticated() -> Bool {
        auth.isUserAuthenticated()
    }
    
    public func signOut() throws {
        try auth.signOut()
    }
    
    // MARK: - Firestore
    public func fetchGames() async throws -> [Game] {
        try await fireStore.fetchGames()
    }
}

// MARK: - Helper Extension for Sign with Apple
extension CFirebase {
    public func generateAppleSignInNonce() -> String {
        auth.randomNonceString()
    }
    
    public func hashAppleSignInNonceSHA256(_ nonce: String) -> String {
        return auth.sha256(nonce)
    }
}
