//
//  TaskList.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import ComposableArchitecture
import SwiftUI

struct TaskList: ReducerProtocol {
    let taskListClient: TaskListClient
    
    struct State: Equatable {
        var tasks: [Task]
        fileprivate var credentials: Credentials?
 
        init(tasks: [Task]? = nil, credentials: Credentials? = nil) {
            self.tasks = tasks ?? []
            self.credentials = credentials
        }
    }
    
    enum Action: Equatable {
        enum Internal: Equatable {
            case credentialsLoaded(Credentials)
        }
        case _internal(Internal)
        
        enum UI: Equatable {
            case didTapCompleteTask(Task)
            case didTapEditTask(Task)
        }
        case ui(UI)
        
        enum NetworkResponse: Equatable {
            case loaded([Task])
            case loadingFailed
        }
        case networkResponse(NetworkResponse)
        
        // public interface
        enum DelegateAction: Equatable {
            case didTapCreateNewTask
            case didTapCompleteTask(Task)
            case didTapEditTask(Task)
        }
        case delegate(DelegateAction)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let ._internal(internalAction):
            return reduceInternal(into: &state, internalAction: internalAction)
        case let .ui(.didTapEditTask(task)):
            return .init(value: .delegate(.didTapEditTask(task)))
        case let .ui(.didTapCompleteTask(task)):
            return .init(value: .delegate(.didTapCompleteTask(task)))
        case let .networkResponse(.loaded(tasks)):
            state.tasks = tasks
            return .none
        case .networkResponse(.loadingFailed):
            // not implemented yet
            return .none
        case .delegate:
            // handled externally, from a higher level reducer
            return .none
        }
    }
    
    private func reduceInternal(into state: inout State, internalAction: Action.Internal) -> EffectTask<Action> {
        switch internalAction {
        case let .credentialsLoaded(credentials):
            state.credentials = credentials
            return Effects.loadTasks(
                taskListClient: taskListClient,
                credentials: credentials
            )
        }
    }
}

private struct Effects {
    static func loadTasks(taskListClient: TaskListClient, credentials: Credentials) -> EffectTask<TaskList.Action> {
        return .task {
            let tasks: [Task]
            do {
                tasks = try await taskListClient.fetchAll(credentials.userID, credentials.apiToken)
            } catch {
                // TODO: implement better error handling
                return .networkResponse(.loadingFailed)
            }
            return .networkResponse(.loaded(tasks))
        }
    }
}
