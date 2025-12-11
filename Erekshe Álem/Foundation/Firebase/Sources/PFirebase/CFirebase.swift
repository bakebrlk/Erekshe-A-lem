//
//  Firebase
//  Firebase.swift
//
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import Foundation
import AuthenticationServices

public final class CFirebase: Sendable {
    // MARK: - Params
    private let auth: CFirebaseAuth = CFirebaseAuth()
    
    public init() {}
    
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
