//
//  Game.swift
//  Domain
//
//  Created by bakebrlk on 06.02.2026.
//

import SwiftUI
import DesignSystem

public struct Game: Codable, Identifiable {
    public var id: UUID = UUID()
    public let title: String
    public let description: String
    public let logo: String
    public let deLogo: String
    public let color: CardColor
    
    enum CodingKeys: String, CodingKey {
        case title, description, logo, deLogo, color
    }
    
    public init(title: String, description: String, logo: String, deLogo: String) {
        self.title = title
        self.description = description
        self.logo = logo
        self.deLogo = deLogo
        self.color = .blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.logo = try container.decode(String.self, forKey: .logo)
        self.deLogo = try container.decode(String.self, forKey: .deLogo)
        
        let colorString = try container.decode(String.self, forKey: .color)
        self.color = CardColor.getType(colorString: colorString)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(logo, forKey: .logo)
        try container.encode(deLogo, forKey: .deLogo)
        try container.encode(color.rawValue, forKey: .color)
    }
}
