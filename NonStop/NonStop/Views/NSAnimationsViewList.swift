//
//  NSAnimationsViewList.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSAnimationsViewList: View {
    var body: some View {
        NavigationView {
            List {
                Section() {
                    NavigationLink(destination: NSStandartCircleAnimation()) {
                        Text("StandartCircleAnimation")
                    }
                    NavigationLink(destination: NSStandartFancyAnimation()) {
                        Text("StandartFancyCircleAnimation")
                    }
                    NavigationLink(destination: NSWatterCircleAnimation()) {
                        Text("WatterCircleAnimation")
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
