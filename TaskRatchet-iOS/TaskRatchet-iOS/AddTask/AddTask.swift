//
//  AddEditTask.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import ComposableArchitecture
import SwiftUI

struct AddTask: ReducerProtocol {
    let addTaskClient: AddTaskClient

    init(addTaskClient: AddTaskClient) {
        self.addTaskClient = addTaskClient
    }

    struct State: Equatable {
        var newTask = NewTask()
    }
    
    enum Action: Equatable {
        enum UI: Equatable {
            case taskNameChanged(String)
            case stakesChanged(cents: Int)
            case stakesIncreased(byCents: Int)
            case dueDateChanged(String)
            case saveButtonPressed
        }
        case ui(UI)
        
        enum NetworkResponse: Equatable {
            case addTaskSuccess(Task)
            case addTaskFailed
        }
        case networkResponse(NetworkResponse)
        
        // public interface
        enum Delegate {
            case didSaveNewTask
        }
        case delegate(Delegate)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .ui(.taskNameChanged(newName)):
            state.newTask.task = newName
            return .none
        case let .ui(.stakesChanged(newStakesCents)):
            state.newTask.cents = newStakesCents
            return .none
        case let .ui(.stakesIncreased(byCents: difference)):
            state.newTask.cents += difference
            return .none
        case let .ui(.dueDateChanged(newDate)):
            state.newTask.due = newDate
            return .none
        case .ui(.saveButtonPressed):
            // not implemented yet - network request
            return .init(value: .delegate(.didSaveNewTask))
        case let .networkResponse(.addTaskSuccess(task)):
            let id = task.id
            // not implemented yet
            return .none
        case .networkResponse(.addTaskFailed):
            // not implemented yet
            return .none
        case .delegate:
            // handled by a higher level reducer
            return .none
        }
    }
}

private struct Effects {
    static func addTask(
        addTaskClient: AddTaskClient,
        newTask: NewTask,
        credentials: Credentials
    ) -> EffectTask<AddTask.Action> {
        return .task {
            let task: Task
            do {
                task = try await addTaskClient.addTask(newTask, credentials)
            } catch {
                // TODO: add proper error handling
                return .networkResponse(.addTaskFailed)
            }
            return .networkResponse(.addTaskSuccess(task))
        }
    }
}
