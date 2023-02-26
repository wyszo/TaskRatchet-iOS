//
//  RootView.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: StoreOf<Root>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.loggedIn {
                NavigationView {
                    // not implemented yet
                    // HomeView/TaskListView
                    // NavigationLink(
                    //    "Task Detail",
                    //    destination: TaskDetailView(
                    //        store: self.store.scope(state:action:)
                    //    )
                    // )
                }
            } else {
                LoginView(
                    store: self.store.scope(
                        state: \.login,
                        action: Root.Action.login
                    )
                )
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: .init(),
                reducer: Root(live: false)
            )
        )
        RootView(
            store: Store(
                initialState: .init(loggedIn: true),
                reducer: Root(live: false)
            )
        )
    }
}
