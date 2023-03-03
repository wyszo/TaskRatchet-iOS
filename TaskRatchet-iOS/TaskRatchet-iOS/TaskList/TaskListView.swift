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
                ScrollView(.vertical) {
                    ForEach(viewStore.tasks, id: \.id) {
                        TaskCell(task: $0)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button("\u{3289} New task") { viewStore.send(.delegate(.didTapCreateNewTask)) }
                        .padding(.trailing)
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
            .onAppear {
                // TODO: get rid of this
                viewStore.send(._internal(.load))
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(
            store: Store(initialState: .init(),
            reducer: TaskList(taskListClient: .mock))
        )
    }
}

private extension Task {
    var statusLine: String {
        return "\(cents/100)$ * \(due) * \(status)"
    }
}

private struct TaskCell: View {
    let task: Task
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.task)
            Text(task.statusLine)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10.0)
        .border(.gray, width: 1)
    }
}
