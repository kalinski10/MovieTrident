//
//  Brand.swift
//  MovieTrident
//
//  Created by kalin's personal on 11/12/2021.
//

import SwiftUI

enum Brand { }

// MARK: - Colour

extension Brand {
    enum Colour { }
}

extension Brand.Colour {
    static let primary = Color(uiColor: .init(red: 0, green: 0.388, blue: 0.239, alpha: 1))
}

// MARK: - Images

extension Brand {
    enum Icons { }
}

extension Brand.Icons {
    static let xmark = "xmark"
    static let settings = "slider.horizontal.3"
    static let star = "star"
    static let video = "video"
    static let timer = "timer"
}
