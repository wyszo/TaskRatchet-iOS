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

                StakesRows(viewStore: viewStore)
                DueDateRows(viewStore: viewStore)
                
                Spacer()
                    .frame(minHeight: 8, maxHeight: 8)

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

// MARK: - Components

private struct DueDateButton: View {
    
    let caption: String
    let dueDate: Date
    let viewStore: ViewStore<AddTask.State, AddTask.Action>
    
    init(caption: String, dueDate: Date, viewStore: ViewStore<AddTask.State, AddTask.Action>) {
        self.caption = caption
        self.dueDate = dueDate
        self.viewStore = viewStore
    }
    
    var body: some View {
        Button(caption) {
            viewStore.send(
                .ui(.dueDateChanged(dueDate))
            )
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
    }
}

struct StakesRows: View {
    let viewStore: ViewStore<AddTask.State, AddTask.Action>
    
    var body: some View {
        StakesRow(viewStore: viewStore)
        PredefinedStakesRow(viewStore: viewStore)
    }
}

struct StakesRow: View {
    
    let viewStore: ViewStore<AddTask.State, AddTask.Action>
    
    var body: some View {
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
                .buttonBorderShape(.roundedRectangle)
        }
    }
}

struct PredefinedStakesRow: View {
    let viewStore: ViewStore<AddTask.State, AddTask.Action>

    var body: some View {
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
    }
}

struct DueDateRows: View {
    let viewStore: ViewStore<AddTask.State, AddTask.Action>

    var body: some View {
        VStack {
            DatePicker("Due date",
                       selection: viewStore.binding(
                        get: \.newTask.dueDate,
                        send: { .ui(.dueDateChanged($0))}
                       ))
            
            // Common task deadlines: 1h, 2h, 4h from now,
            // day, week, month from now
            HStack {
                DueDateButton(caption: "In 1h", dueDate: .now.dateByAddingHours(1), viewStore: viewStore)
                DueDateButton(caption: "In 2h", dueDate: .now.dateByAddingHours(2), viewStore: viewStore)
                DueDateButton(caption: "In 4h", dueDate: .now.dateByAddingHours(4), viewStore: viewStore)
                
                Spacer()
                
                DueDateButton(caption: "In a day", dueDate: .now.dateByAddingDay, viewStore: viewStore)
                DueDateButton(caption: "In a week", dueDate: .now.dateByAddingWeek, viewStore: viewStore)
                DueDateButton(caption: "In a month", dueDate: .now.dateByAddingMonth, viewStore: viewStore)
            }
        }
    }
}
