//
//  NSWatterCircleAnimation.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSWatterCircleAnimation: View {
    @EnvironmentObject var initialTimer: NSInitialTimer

    var body: some View {
        NSCircleWaveView(percent: initialTimer.timeLeftPersentage)
            .frame(width: 300, height: 300)
            .onAppear {
                initialTimer.startTimer()
            }
            .onDisappear {
                initialTimer.stopTimer()
            }
    }
}

struct NSWatterCircleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        NSWatterCircleAnimation()
    }
}

struct NSWaveShape: Shape {

    var offset: Angle
    var percent: Double

    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }

    func path(in rect: CGRect) -> Path {
        var p = Path()

        // empirically determined values for wave to be seen
        // at 0 and 100 percent
        let lowfudge = 0.02
        let highfudge = 0.98

        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = 0.015 * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)

        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))

        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }

        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()

        return p
    }
}

struct NSCircleWaveView: View {

    @EnvironmentObject var initialTimer: NSInitialTimer

    @State private var waveOffset = Angle(degrees: 0)
    let percent: Double

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("\(initialTimer.getTimeRemainString())")
                    .foregroundColor(.black)
                    .font(Font.system(size: 0.15 * min(geo.size.width, geo.size.height)))
                Circle()
                    .stroke(Color.blue,
                            lineWidth: 0.025 * min(geo.size.width, geo.size.height))
                    .overlay(
                        NSWaveShape(offset: Angle(degrees: self.waveOffset.degrees),
                                    percent: Double(percent)/100)
                            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                            .clipShape(Circle().scale(0.94))
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}
