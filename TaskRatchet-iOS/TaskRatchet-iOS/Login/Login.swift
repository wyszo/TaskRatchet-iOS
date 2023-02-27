//
//  Login.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import Foundation
import ComposableArchitecture

struct Login: ReducerProtocol {
    let loginClient: LoginClient

    struct State: Equatable {
        var userID: String = ""
        var apiToken: String = ""
        var loginRequestInFlight = false
        var loggedIn = false
    }

    enum Action: Equatable {
        enum UIAction: Equatable {
            case loginPressed
            case userIdChanged(String)
            case apiTokenChanged(String)
        }
        case ui(UIAction)
        
        enum NetworkResponse: Equatable {
            case login(Profile)
            case loginAttemptFailed
        }
        case networkResponse(NetworkResponse)
        
        // public interface
        enum DelegateAction: Equatable {
            case didLogin
        }
        case delegate(DelegateAction)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .ui(.loginPressed):
            return Effects.loginPressed(loginClient: loginClient, userID: state.userID, apiToken: state.apiToken)
        case let .ui(.userIdChanged(userID)):
            state.userID = userID
            return .none
        case let .ui(.apiTokenChanged(token)):
            state.apiToken = token
            return .none
        case .networkResponse(.login):
//        case let .networkResponse(.login(profile)):
            // not implented yet
            return .none
        case .networkResponse(.loginAttemptFailed):
            // not implemented yet
            return .none
        case .delegate:
            // intentional, should be handled by a higher level reducer
            return .none
        }
    }
    
    private struct Effects {
        static func loginPressed(loginClient: LoginClient, userID: String, apiToken: String) -> EffectTask<Action> {
            return .task {
                let profile: Profile
                do {
                    profile = try await loginClient.fetchProfile(userID, apiToken)
                } catch {
                    return .networkResponse(.loginAttemptFailed)
                }
                return .networkResponse(.login(profile))
            }
        }
    }
}
