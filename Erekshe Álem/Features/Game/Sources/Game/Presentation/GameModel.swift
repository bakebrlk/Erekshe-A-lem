//
//  Game
//  GameModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.01.2026.
//  We'll make it work, and I believe you 🚀
//

import Foundation
import PFirebase

struct GameModel {
    var state: RequestState = .loading
    var canForceUpdate: Bool = false
    var loadingText: String = ""
    var loadingFullText: String = "Играй и развивайся с Блуми"
}
