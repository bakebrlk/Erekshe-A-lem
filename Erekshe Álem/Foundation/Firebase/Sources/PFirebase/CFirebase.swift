//
//  Firebase
//  Firebase.swift
//
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import Foundation
import AuthenticationServices

public struct CFirebase {
    // MARK: - Params
    private var auth: CFirebaseAuth = CFirebaseAuth()
    
    public init() {}
    
    // MARK: - Auth Functions
    public func signInWithEmail(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.signInWithEmail(email: email, password: password, completion: completion)
    }
    
    public func signInWithApple(
        idToken: String,
        rawNonce: String,
        fullName: PersonNameComponents?,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.signInWithApple(
            idToken: idToken,
            rawNonce: rawNonce,
            fullName: fullName,
            completion: completion
        )
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
