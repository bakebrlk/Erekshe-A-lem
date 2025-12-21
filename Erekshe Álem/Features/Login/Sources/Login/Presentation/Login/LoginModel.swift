//
//  Login
//  LoginModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 14.11.2025.
//  We'll make it work, and I believe you 🚀
//

import Foundation
import PFirebase

struct LoginModel {
    var email: String = ""
    var password: String = ""
    var state: RequestState = .loading
    var currentNonce: String? = nil
    var currentPage = 0
    var isAnimated: Bool = false
}

struct OnBording: Hashable {
    let id: Int
    let titleFirst: String
    let titleSecond: String
    let titleThird: String
    let description: String
}
