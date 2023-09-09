//
//  AddTaskView.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import ComposableArchitecture
import SwiftUI

struct AddTaskView: View {
    let store: StoreOf<AddTask>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                TextField("Task name",
                    text: viewStore.binding(
                      get: \.newTask.task,
                      send: { .ui(.taskNameChanged($0)) }
                    )
                )
                    .textFieldStyle(.roundedBorder)

                HStack {
                    Text("Stakes:")
                    TextField("Stakes - cents:",
                              text: viewStore.binding(
                                get: { String($0.newTask.cents) },
                                send: { .ui(.stakesChanged($0)) }
                              )
                    )
                    .textFieldStyle(.roundedBorder)
                    Text("cents")
                    Text("= \(viewStore.state.newTask.stakesInDolarsString)")
                }

                Text("Due date format: DD/MM/YYYY, HH:MMPM")
                Text("For example: 3/25/2023, 11:59PM")

                TextField("Due date",
                    text: viewStore.binding(
                        get: \.newTask.due,
                        send: { .ui(.dueDateChanged($0)) }
                    )
                )
                    .textFieldStyle(.roundedBorder)
                Text("Timezone: ")
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding()
            .toolbar {
                Button("Save") {
                    viewStore.send(.ui(.saveButtonPressed))
                }
            }
        }
    }
}

// MARK: - Previews

struct AddTaskViewPreview: PreviewProvider {
    static var previews: some View {
        AddTaskView(
            store: .init(
                initialState: AddTask.State.init(),
                reducer: AddTask(addTaskClient: .mock)
            )
        )
    }
}
