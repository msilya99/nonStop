//
//  NSColors.swift
//  NonStop
//
//  Created by Ilya Maslou on 11.11.21.
//

import SwiftUI

class NSThemeColors: ObservableObject {

    // MARK: - variables

    private var isDarkTheme: Bool {
        return SYS.appTheme == .dark
    }

    // MARK: - colors

    var baseColor: Color {
        return isDarkTheme ? .white : .black
    }

    var invertedBaseColor: Color {
        return isDarkTheme ? .black : .white
    }
}
