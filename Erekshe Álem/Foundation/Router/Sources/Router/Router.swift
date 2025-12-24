// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Nivelir
import UIKit

public typealias AppScreen = AnyScreen<UIViewController>

public protocol IAppRouting: AnyObject {
    var navigator: ScreenNavigator { get }
    func start()
}

@MainActor
public protocol ICoordinator: AnyObject {
    var navigator: ScreenNavigator { get }
    func makeView() -> AnyView
    func asAnyScreen() -> AppScreen
}

@MainActor
public protocol IDestinationCoordinator: ICoordinator {
    associatedtype Destination
    func navigate(to destination: Destination)
}

fileprivate struct HostingScreen: Screen {
    typealias Container = UIViewController
    typealias Observer = Never

    let name: String
    let traits: Set<AnyHashable>
    weak var coordinator: ICoordinator?

    @MainActor
    func build(navigator: ScreenNavigator) -> UIViewController {
        guard let coordinator else {
            return UIHostingController(rootView: AnyView(EmptyView()))
        }
        return UIHostingController(rootView: coordinator.makeView())
    }
}

extension ICoordinator {
    public func asAnyScreen() -> AppScreen {
        let screen = HostingScreen(
            name: String(describing: Self.self),
            traits: [],
            coordinator: self
        )

        return screen.eraseToAnyScreen()
    }
}
