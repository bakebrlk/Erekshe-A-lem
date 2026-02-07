//
//  CardColor.swift
//  DesignSystem
//
//  Created by bakebrlk on 06.02.2026.
//

import SwiftUI

public enum CardColor: String, Codable {
    case blue
    case yellow
    case green
    
    public static func getType(colorString: String) -> Self {
        switch colorString {
            case CardColor.blue.rawValue: return .blue
            case CardColor.yellow.rawValue: return .yellow
            case CardColor.green.rawValue: return .green
            default: return .blue
        }
    }
    
    public var mainColor: Color {
        switch self {
            case .blue: .blue4FF
            case .yellow: .yellowB25
            case .green: .greenC500
        }
    }
    
    public var logoColor: Color {
        switch self {
            case .blue: .blue3FF
            case .yellow: .yellowC97
            case .green: .greenF83
        }
    }
    
    public var strokeColor: Color {
        switch self {
            case .blue: .blue1FF
            case .yellow: .yellow1D5
            case .green: .greenD402
        }
    }
}
