//
//  FirebaseAuth.swift
//  Firebase
//
//  Created by bakebrlk on 30.11.2025.
//

import FirebaseAuth
import FirebaseCore

struct CFirebaseAuth {
    
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
}
