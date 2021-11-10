//
//  NSMainTabsView.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSMainTabsView: View {

    // MARK: - variables

    @Environment(\.colorScheme) var colorScheme

    @State private var selectedItem = 1
    @State private var shouldShowActionSheet = false

    // MARK: - views

    var body: some View {
        ZStack {
            TabView(selection: $selectedItem) {
                NSAnimationsViewList()
                    .tag(1)
                NSTimerView()
                    .tabItem {
                        Label("Planner",
                              systemImage: "list.bullet.rectangle")
                    }
                    .tag(2)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button {
                    selectedItem = 1
                } label: {
                    Label("Now",
                          systemImage: "clock")
                }.padding(20)

                Spacer()

                NSAddItemTabButon {
                    selectedItem = 2
                }
                    .frame(width: SYS.screenSize.width / 7,
                           height: SYS.screenSize.width / 7)
                    .padding()
                    .offset(x: 0, y: -8)

                Spacer()
                Button {
                    selectedItem = 2
                } label: {
                    Label("Planner",
                          systemImage: "list.bullet.rectangle")
                }
                Spacer()
            }
        }
        .actionSheet(isPresented: $shouldShowActionSheet) {
            ActionSheet(title: Text("Title"),
                        message: Text("Message"),
                        buttons: [
                            .cancel { shouldShowActionSheet.toggle() }
                        ])
        }
    }
}
