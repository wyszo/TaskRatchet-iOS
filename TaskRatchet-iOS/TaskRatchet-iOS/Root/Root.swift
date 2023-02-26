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
        var loggedIn = false
    }
    
    enum Action: Equatable {
        case login(Login.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
                case .login(.delegate(.didLogin)):
                    state.loggedIn = true
                    return .none
                default:
                    return .none
            }
        }
        Scope(state: \.login, action: /Action.login) {
            Login(loginClient: live ? .live : .mock)
        }
    }
}

extension LoginClient {
    static let live = Self { userID, apiToken in
        // not implemented yet
        return false
    }
}
