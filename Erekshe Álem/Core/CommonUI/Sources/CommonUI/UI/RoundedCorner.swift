//
//  RoundedCorner.swift
//  CommonUI
//
//  Created by bakebrlk on 27.01.2026.
//

import SwiftUI

public struct RoundedCorner: Shape {
    private var radius: CGFloat
    private var corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
