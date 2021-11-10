//
//  NSPressModifier.swift
//  NonStop
//
//  Created by Ilya Maslou on 10.11.21.
//

import SwiftUI

struct NSPressModifier: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void

    func body(content: Content) -> some View {
        content.simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}
