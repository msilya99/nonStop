//
//  NSAnimationsViewList.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSAnimationsViewList: View {
    @EnvironmentObject var initialTimer: NSInitialTimer

    var body: some View {
        NavigationView {
            List {
                Section() {
                    NavigationLink(destination: NSCircleProgressView(initialTimer: initialTimer)) {
                        Text("StandartCircleAnimation")
                    }
                    NavigationLink(destination: NSFancyLoaderView()) {
                        Text("StandartFancyCircleAnimation")
                    }
                    NavigationLink(destination: NSWatterCircleAnimationProgressView(initialTimer: initialTimer)) {
                        Text("WatterCircleAnimation")
                    }
                    NavigationLink(destination: NSEllipseProgressView()) {
                        Text("EllipseAnimation")
                    }
                    NavigationLink(destination: NSDotStyleProgressView(initialTimer: initialTimer)) {
                        Text("DotStyleProgress")
                    }
                }
            }.navigationTitle("Animations")
                .listStyle(InsetGroupedListStyle())
        }
    }
}

struct NSAnimationsViewList_Previews: PreviewProvider {
    static var previews: some View {
        NSAnimationsViewList()
    }
}
