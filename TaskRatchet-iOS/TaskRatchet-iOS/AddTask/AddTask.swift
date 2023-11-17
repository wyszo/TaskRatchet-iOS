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
        var credentials: Credentials?
    }
    
    enum Action: Equatable {
        enum Internal: Equatable {
            case credentialsSet(Credentials?)
        }
        case _internal(Internal)
        
        enum UI: Equatable {
            case taskNameChanged(String)
            case stakesChanged(cents: Int)
            case stakesIncreased(byCents: Int)
            case dueDateChanged(Date)
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
        case let ._internal(internalAction):
            return reduceInternal(into: &state, internalAction: internalAction)
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
            state.newTask.dueDate = newDate
            return .none
        case .ui(.saveButtonPressed):
            if let credentials = state.credentials {
                return Effects.addTask(addTaskClient: addTaskClient, newTask: state.newTask, credentials: credentials)
            } else {
                // TODO: no api credentials, show error state
                return .none
            }
        case let .networkResponse(.addTaskSuccess(task)):
            let id = task.id
            // TODO: not implemented yet
            // return .none
            return .init(value: .delegate(.didSaveNewTask))
        case .networkResponse(.addTaskFailed):
            // TODO: not implemented yet
            return .none
        case .delegate:
            // handled by a higher level reducer
            return .none
        }
    }
    
    private func reduceInternal(into state: inout State, internalAction: Action.Internal) -> EffectTask<Action> {
        switch internalAction {
        case let .credentialsSet(credentials):
            state.credentials = credentials
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
