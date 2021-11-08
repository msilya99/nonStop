//
//  View + EX.swift
//  NonStop
//
//  Created by Ilya Maslou on 9.11.21.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
