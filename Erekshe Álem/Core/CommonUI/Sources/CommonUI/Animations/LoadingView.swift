//
//  LoadingView.swift
//  CommonUI
//
//  Created by bakebrlk on 10.12.2025.
//

import Lottie
import SwiftUI

public struct LoadingView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            LottieView(animation: .named("ereksheLoading"))
                .playing()
                .looping()
                .frame(
                    width: UIScreen.main.bounds.width/4,
                    height: UIScreen.main.bounds.width/4
                )
                .padding(10)
            Spacer()
        }
    }
}

public final class OrientationLock {
    @MainActor public static var lock: UIInterfaceOrientationMask = .portrait
}
