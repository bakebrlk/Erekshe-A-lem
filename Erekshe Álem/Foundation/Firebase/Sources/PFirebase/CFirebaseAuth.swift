//
//  FirebaseAuth.swift
//  Firebase
//
//  Created by bakebrlk on 30.11.2025.
//

import FirebaseAuth
import FirebaseCore
import AuthenticationServices
import CryptoKit
import GoogleSignIn

public final class CFirebaseAuth: Sendable {
    
    public init() {}
    
    // MARK: - SignUp with Email
    func signUpEmail(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    // MARK: - Email
    func signInWithEmail(
        email: String,
        password: String
    ) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    // MARK: - Apple
    func signInWithApple(
        idToken: String,
        rawNonce: String,
        fullName: PersonNameComponents?
    ) async throws {
        let credential = OAuthProvider.appleCredential(
            withIDToken: idToken,
            rawNonce: rawNonce,
            fullName: fullName
        )
        
        try await Auth.auth().signIn(with: credential)
    }
    
    // MARK: - Google
    func signInWithGoogle(
        idToken: String,
        accessToken: String
    ) async throws {
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )
        try await Auth.auth().signIn(with: credential)
    }
    
    // MARK: - User
    func isUserAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            print("✅ Successfully signed out")
        } catch let signOutError as NSError {
            print("❌ Error signing out: \(signOutError.localizedDescription)")
            throw signOutError
        }
    }
}

// MARK: - Helper Functions
extension CFirebaseAuth {
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
