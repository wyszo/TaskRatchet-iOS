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

                // Stakes row
                // TODO: extract to a separate view
                HStack {
                    Text("Stakes:")
                    TextField("Stakes (dollars):",
                              text: viewStore.binding(
                                get: { $0.newTask.stakes.dollarsRoundedDownString },
                                send: { .ui(.stakesChanged(cents: (Int($0) ?? 0) * 100)) }
                              )
                    )
                        .frame(maxWidth: 50)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                    Text("$")
                    Spacer()
                    
                    Group {
                        Button("(-1)") {
                            viewStore.send(.ui(.stakesIncreased(byCents: -100)))
                        }
                        Button("(+1)") {
                            viewStore.send(.ui(.stakesIncreased(byCents: 100)))
                        }
                    }
                        .buttonStyle(.bordered)
                }
                
                // Predefined stakes row
                // TODO: extract to a separate view
                HStack{
                    Spacer()
                    Group {
                        Button("$2") {
                            viewStore.send(.ui(.stakesChanged(cents: 200)))
                        }
                        Button("$5") {
                            viewStore.send(.ui(.stakesChanged(cents: 500)))
                        }
                        Button("$10") {
                            viewStore.send(.ui(.stakesChanged(cents: 1000)))
                        }
                    }
                    .buttonStyle(.bordered)
                }
                

                // Due date row
                // TODO: extract this to a separate view
                Group {
                    DatePicker("Due date",
                               selection: viewStore.binding(
                                get: \.newTask.dueDate,
                                send: { .ui(.dueDateChanged($0))}
                               ))
                    // TODO: add handy common dates buttons:
                    //  - day from now
                    //  - week from now
                    //  - month from now
                }

                HStack {
                    // TODO: hide this from the UI
                    Text("Timezone: ")
                    Spacer()
                }
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
