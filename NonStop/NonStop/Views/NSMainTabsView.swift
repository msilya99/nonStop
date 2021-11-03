//
//  NSMainTabsView.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSMainTabsView: View {
    var body: some View {
        TabView {
            NSAnimationsViewList().tabItem {
                Label("Animations",
                      systemImage: "timelapse")
            }

            NSTimerView()
                .tabItem {
                    Label("Timer",
                          systemImage: "timer")
                }
        }
    }
}

struct NSMainTabsView_Previews: PreviewProvider {
    static var previews: some View {
        NSMainTabsView()
    }
}
