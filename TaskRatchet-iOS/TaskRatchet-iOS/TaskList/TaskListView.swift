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
                    ForEach(viewStore.filteredTasks, id: \.id) { task in
                        TaskCell(
                            task: task,
                            completeCallback: {
                                viewStore.send(
                                    .ui(.didTapCompleteTask(task))
                                )
                            },
                            editCallback: {
                                viewStore.send(
                                    .ui(.didTapEditTask(task))
                                )
                            }
                        )
                    }
                }
                Spacer()
                HStack {
                    Button("Filter: \(viewStore.filter.description)") {
                        viewStore.send(
                            .ui(.didTapChangeFilter)
                        )
                    }
                    Spacer()
                    Button("\u{3289} New task") { viewStore.send(.delegate(.didTapCreateNewTask)) }
                        .padding(.trailing)
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(
            store: .init(
                initialState: .init(
                    tasks: [.mocked, .mocked, .mocked],
                    credentials: .mock
                ),
                reducer: TaskList(taskListClient: .mock))
        )
    }
}

private extension Task {
    var statusLine: String {
        return "\(cents/100)$ * \(due) * \(status.description)"
    }
}

struct TaskCell: View {
    let task: Task
    let completeCallback: () -> ()
    let editCallback: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("\u{2610}") {
                    completeCallback()
                }
                    .padding(.horizontal, 5.0)
                VStack(alignment: .leading) {
                    Text(task.task)
                    Text(task.statusLine)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10.0)
        .border(.gray, width: 1)
    }
}
