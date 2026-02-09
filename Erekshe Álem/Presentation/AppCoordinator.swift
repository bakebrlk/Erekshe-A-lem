//
//  AppView.swift
//  Erekshe Álem
//
//  Created by bakebrlk on 09.02.2026.
//

import SwiftUI
import PFirebase
import Router
import Game
import Login
import Nivelir

public final class AppCoordinator: IDestinationCoordinator {
    // MARK: - Params
    @ObservedObject private var firebase: CFirebase = CFirebase.shared
    public let navigator: ScreenNavigator
    public typealias Destination = AppDestination

    public init(navigator: ScreenNavigator) {
        self.navigator = navigator
    }
    
    public func navigate(to destination: AppDestination) {

    }

    
    public func makeView() -> AnyView {
        AnyView(body)
    }
    
    public var body: some View {
        switch firebase.loggedIn {
        case true : GameCoordinator(navigator: navigator).makeView()
        case false : LoginCoordinator(navigator: navigator).makeView()
        }
    }
}
