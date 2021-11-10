//
//  NSAddItemTabButon.swift
//  NonStop
//
//  Created by Ilya Maslou on 10.11.21.
//

import SwiftUI

struct NSAddItemTabButon: View {

    // MARK: - variables

    @Environment(\.colorScheme) var colorScheme

    @State var isPressed: Bool = false
    var strokeWidth: CGFloat = 4
    var imageName: String = "plus"
    var action: () -> Void
    private var imageShrinkCoefficient: CGFloat = 1.8

    // MARK: initialization

    init(action: @escaping () -> Void) {
        self.action = action
    }

    // MARK: - views

    var body: some View {
        GeometryReader { geo in
            let minSide = min(geo.size.width, geo.size.height)
            ZStack {
                Circle()
                    .stroke(colorScheme == .dark ? .black : .white,
                            lineWidth: strokeWidth)
                    .background(Circle()
                                    .fill(colorScheme == .dark ? .white : .black))
                    .frame(width: minSide)

                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: minSide / imageShrinkCoefficient ,
                           height: minSide / imageShrinkCoefficient)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
            }
        }
        .scaleEffect(isPressed ? 1.2 : 1)
        .animation(.easeOut(duration: 0.2), value: isPressed)
        .modifier(NSPressModifier(
            onPress: { self.isPressed = true },
            onRelease: {
                self.isPressed = false
                self.action()
            }))
    }
}
