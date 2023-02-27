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
        var tasks: [Task] = []
        
        fileprivate var userID: String = ""
        fileprivate var apiToken: String = ""
    }
    
    enum Action: Equatable {
        enum Internal: Equatable {
            case load
            case credentialsLoaded(String, String)
        }
        case _internal(Internal)
        
        enum UI: Equatable {
        }
        case ui(UI)
        
        enum NetworkResponse: Equatable {
            case loaded([Task])
            case loadingFailed
        }
        case networkResponse(NetworkResponse)
        
        // public interface
        enum DelegateAction: Equatable {
            case didTapTask(Task)
        }
        case delegate(DelegateAction)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        // TODO: split to a separate internal reducer
        case ._internal(.load):
            return Effects.loadCredentials(taskListClient: taskListClient)
        case let ._internal(.credentialsLoaded(userID, apiToken)):
            state.userID = userID
            state.apiToken = apiToken
            return Effects.loadTasks(
                taskListClient: taskListClient,
                userID: state.userID,
                apiToken: state.apiToken
            )
        case .ui:
            return .none
        case let .networkResponse(.loaded(tasks)):
            state.tasks = tasks
            return .none
        case .networkResponse(.loadingFailed):
            // not implemented yet
            return .none
        case .delegate:
            // handled externally, from the higher level reducer
            return .none
        }
    }
}

private struct Effects {
    static func loadTasks(taskListClient: TaskListClient, userID: String, apiToken: String) -> EffectTask<TaskList.Action> {
        return .task {
            let tasks: [Task]
            do {
                tasks = try await taskListClient.fetchAll(userID, apiToken)
            } catch {
                // TODO: implement better error handling
                return .networkResponse(.loadingFailed)
            }
            return .networkResponse(.loaded(tasks))
        }
    }

    static func loadCredentials(taskListClient: TaskListClient) -> EffectTask<TaskList.Action> {
        return .task {
            let (userID, apiToken) = taskListClient.loadCredentials()
            return ._internal(
                .credentialsLoaded(userID, apiToken)
            )
        }
    }
}
