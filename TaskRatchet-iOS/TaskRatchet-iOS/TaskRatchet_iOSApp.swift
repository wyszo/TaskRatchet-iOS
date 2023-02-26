//
//  TaskRatchet_iOSApp.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct TaskRatchet_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: .init(),
                    reducer: Root(live: true)
                )
            )
        }
    }
}
