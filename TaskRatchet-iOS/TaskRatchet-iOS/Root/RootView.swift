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
        // TODO: migrate to the new iOS16 way of navigating like so:
        /**
        NavigationStack {
            // TaskListView(...)
        }
        .navigationDestination(
            isPresented: Binding<Bool>,
            destination: () -> View
        )
        */

        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.loggedIn {
                // Old (deprecated) way of navigating (pre iOS16)
                NavigationView {
                    VStack {
                        TaskListView(
                            store: self.store.scope(
                                state: \.taskList,
                                action: Root.Action.taskList
                            )
                        )
                        
                        // Existing task detail navi link
                        // Not implemented yet
                        // NavigationLink(
                        //    "Task Detail",
                        //    destination: TaskDetailView(
                        //        store: self.store.scope(state:action:)
                        //    )
                        // )
                        
                        // Add new task navi link
                        NavigationLink(
                            destination: IfLetStore(
                                self.store.scope(
                                    state: \.addTask,
                                    action: Root.Action.addTask
                                ), then: {
                                    AddTaskView(store: $0)
                                }
                            ),
                            isActive: viewStore.binding(
                                get: { $0.addTask != nil },
                                send: { Root.Action.navigateTo($0 ? .addTask : nil) }
                            ),
                            label: EmptyView.init
                        )
                        .hidden()
                    }
                }
            } else {
                LoginView(
                    store: self.store.scope(
                        state: \.login,
                        action: Root.Action.login
                    )
                )
                .onAppear {
                    // TODO: get rid of this
                    viewStore.send(.login(._internal(.viewCreated)))
                }
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
                initialState: .init(credentials: .mock),
                reducer: Root(live: false)
            )
        )
    }
}
