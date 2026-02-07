//
//  CFireStore.swift
//  PFirebase
//
//  Created by bakebrlk on 07.02.2026.
//

import Domain
@preconcurrency
import FirebaseFirestore

public final class CFireStore: Sendable {
    public init() {}
    
    private let db = Firestore.firestore()
    
    public func fetchGames() async throws -> [Game] {
        let snapshot = try await db.collection(CCollection.games.rawValue).getDocuments()
        let games: [Game] = snapshot.documents.compactMap { document in
            do {
                return try document.data(as: Game.self)
            } catch {
                print("❌ Ошибка декодирования игры \(document.documentID): \(error)")
                return nil
            }
        }
        
        return games
    }
}
