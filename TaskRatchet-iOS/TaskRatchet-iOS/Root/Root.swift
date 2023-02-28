//
//  Root.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import ComposableArchitecture

struct Root: ReducerProtocol {
    let live: Bool

    struct State: Equatable {
        var login = Login.State()
        var taskList = TaskList.State()
        var addTask: AddTask.State? = nil
        var loggedIn = false
    }
    
    enum Action: Equatable {
        case login(Login.Action)
        case taskList(TaskList.Action)
        case addTask(AddTask.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.taskList, action: /Action.taskList) {
            TaskList(taskListClient: live ? .live : .mock)
        }
        Scope(state: \.login, action: /Action.login) {
            Login(loginClient: live ? .live : .mock)
        }
        .ifLet(\.addTask, action: /Action.addTask) {
            AddTask(addTaskClient: live ? .live : .mock)
        }
        Reduce { state, action in
            switch action {
                case .login(.delegate(.didLogin)):
                    state.loggedIn = true
                    return .none
                case .taskList(.delegate(.didTapTask)):
                    // Not implemented yet
                    return .none
                case .taskList(.delegate(.didTapCreateNewTask)):
                    state.addTask = .init()
                    return .none
                default:
                    return .none
            }
        }
    }
}
