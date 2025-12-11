//
//  Login
//  RegistryModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 12.12.2025.
//  We'll make it work, and I believe you 🚀
//

import Foundation
import PFirebase

struct RegistryModel {
    var state: RequestState = .display
    var currentNonce: String? = nil
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
}
