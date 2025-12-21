// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Nivelir

public protocol IRoutable {
    associatedtype Route
    func navigate(to route: Route)
}

public protocol ICoordinator: AnyObject {
    var navigator: ScreenNavigator { get }
    var childCoordinators: [ICoordinator] { get set }
    
    func start()
    func addChild(_ coordinator: ICoordinator)
    func removeChild(_ coordinator: ICoordinator)
}

public extension ICoordinator {
    func addChild(_ coordinator: ICoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: ICoordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
