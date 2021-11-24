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
                    .stroke(NSThemeColors.sh.getColorByType(.baseInverted),
                            lineWidth: strokeWidth)
                    .background(Circle()
                                    .fill(NSThemeColors.sh.getColorByType(.base)))
                    .frame(width: minSide)

                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: minSide / imageShrinkCoefficient,
                           height: minSide / imageShrinkCoefficient)
                    .foregroundColor(themeColorType: .baseInverted)
            }
        }
        .scaleEffect(isPressed ? 1.2 : 1)
        .animation(.easeOut(duration: 0.3), value: isPressed)
        .modifier(NSPressModifier(
            onPress: { self.isPressed = true },
            onRelease: {
                self.isPressed = false
                self.action()
            }))
        .frame(width: SYS.screenSize.width / 7,
               height: SYS.screenSize.width / 7)
        .padding()
    }
}
