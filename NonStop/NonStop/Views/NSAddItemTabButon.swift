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

    var strokeWidth: CGFloat = 4
    var imageName: String = "plus"
    private var imageShrinkCoefficient: CGFloat = 1.8

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
    }
}
