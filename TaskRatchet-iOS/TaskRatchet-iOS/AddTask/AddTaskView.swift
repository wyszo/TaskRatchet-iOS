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
                TextField("Stakes - cents:",
                    text: viewStore.binding(
                        get: { String($0.newTask.cents) },
                        send: { .ui(.stakesChanged($0)) }
                    )
                )
                Text("Due date format: DD/MM/YYYY, HH:MMPM")
                Text("For example: 3/25/2023, 11:59PM")
                TextField("Due date",
                    text: viewStore.binding(
                        get: \.newTask.due,
                        send: { .ui(.dueDateChanged($0)) }
                    )
                )
                Text("Timezone: ")
            }
            .padding()
            .toolbar {
                Button("Save") {
                    viewStore.send(.ui(.saveButtonPressed))
                }
            }
        }
    }
}
