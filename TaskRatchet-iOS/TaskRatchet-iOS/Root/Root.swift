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
        
        // TODO: merge that state with the Route...
        var addTask: AddTask.State? = nil
        
        enum LoggedInRoute: Equatable {
            case none
            case addTask
            // case editTask(Task)
        }
        var route: LoggedInRoute = .none

        var credentials: Credentials?
        var loggedIn: Bool {
            return credentials != nil
        }
    }
    
    enum Action: Equatable {
        case login(Login.Action)
        case taskList(TaskList.Action)
        case addTask(AddTask.Action)

        case navigateTo(State.LoggedInRoute?)
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
                case let .login(.delegate(.didLogin(credentials))):
                    state.credentials = credentials
                    return .init(value:
                        .taskList(._internal(.credentialsLoaded(credentials)))
                    )
                case .taskList(.delegate(.didTapCreateNewTask)):
                    state.addTask = .init()
                    return .init(value:
                            .addTask(._internal(.credentialsSet(state.credentials)))
                    )
                case .taskList(.delegate(.didTapEditTask)):
                    // TODO: Not implemented yet
                    return .none
                case .taskList(.delegate(.didTapCompleteTask)):
                    // TODO: Not implemented yet
                    return .none
                case .addTask(.delegate(.didSaveNewTask)):
                    state.addTask = nil
                    return .none
                default:
                    return .none
            }
        }
    }
}
