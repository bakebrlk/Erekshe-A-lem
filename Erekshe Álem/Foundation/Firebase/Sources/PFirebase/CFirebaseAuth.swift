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

struct CFirebaseAuth {
    
    // MARK: - Email
    func signInWithEmail(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            print("User signed in successfully!")
            completion(.success(()))
        }
    }
    
    // MARK: - Apple
    func signInWithApple(
        idToken: String,
        rawNonce: String,
        fullName: PersonNameComponents?,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let credential = OAuthProvider.appleCredential(withIDToken: idToken,
                                                       rawNonce: rawNonce,
                                                       fullName: fullName)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            print("User signed in successfully with Apple!")
            completion(.success(()))
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
