//
//  Firebase
//  Firebase.swift
//
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import Foundation

public struct CFirebase {
    // MARK: - Params
    private var auth: CFirebaseAuth = CFirebaseAuth()
    
    public init() {}
    
    // MARK: - Functions
    public func signInWithEmail(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.signInWithEmail(email: email, password: password, completion: completion)
    }
}
