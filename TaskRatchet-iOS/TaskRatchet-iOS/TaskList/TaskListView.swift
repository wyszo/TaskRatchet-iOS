//
//  TaskListView.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import ComposableArchitecture
import SwiftUI

struct TaskListView: View {
    let store: StoreOf<TaskList>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                ForEach(viewStore.tasks, id: \.id) { task in
                    Text(task.task)
                }
            }
            .onAppear {
                // TODO: get rid of this
                viewStore.send(._internal(.load))
            }
        }
    }
}
