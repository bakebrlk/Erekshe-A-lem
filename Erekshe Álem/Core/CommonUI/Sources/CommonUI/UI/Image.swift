//
//  Image.swift
//  CommonUI
//
//  Created by bakebrlk on 27.01.2026.
//

import SwiftUI
import DesignSystem

public extension Image {
    init(_ name: ImageNames) {
        self.init(name.rawValue)
    }
}
