//
//  Profile
//  ProfileViewModel.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.02.2026.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import Combine
import PFirebase
import CommonUI

@MainActor
final class ProfileViewModel: ObservableObject {
    // MARK: Params
    @Published private var model: ProfileModel
    private weak var coordinator: ProfileCoordinator?
    private var firebase: CFirebase = CFirebase.shared
    
    // MARK: Init
    init(dependencies: Dependencies) {
        self.model = ProfileModel()
        self.coordinator = dependencies.coordinator
    }
    
    // MARK: - Navigate
    func navigateToLogin() {
        coordinator?.navigate(to: .signOut)
    }
    
    // MARK: - Network
    func fetchProfile() {
        
    }
    
    // MARK: - Modeling
    func getEmail() {

    }
    
    // MARK: - Action
    func signOut() {
        do {
            try firebase.signOut()
            rotate(.portrait)
            coordinator?.navigate(to: .signOut)
        } catch {
            
        }
    }
    
    func rotate(_ orientation: UIInterfaceOrientationMask) {
        OrientationLock.lock = orientation
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let preferences = UIWindowScene.GeometryPreferences.iOS(
            interfaceOrientations: orientation
        )
        
        scene.requestGeometryUpdate(preferences) { error in
            print("Rotation error:", error.localizedDescription)
        }
    }
}

// MARK: - Dependencies
extension ProfileViewModel {
    struct Dependencies {
        
        var coordinator: ProfileCoordinator
        
        public init(
            coordinator: ProfileCoordinator
        ) {
            self.coordinator = coordinator
        }
    }
}
