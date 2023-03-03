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
        
        var alert: AlertState<Action>? {
            didSet { networkIndicator = false }
        }
        var networkIndicator = false
        var loggedIn = false
    }

    enum Action: Equatable {
        enum Internal: Equatable {
            case viewCreated
            case credentialsLoaded(String, String)
            case tryAutologin
        }
        case _internal(Internal)
        
        enum UIAction: Equatable {
            case loginPressed
            case userIdChanged(String)
            case apiTokenChanged(String)
            
            enum AlertAction: Equatable {
               case dismissed
            }
            case alert(AlertAction)
        }
        case ui(UIAction)
        
        enum NetworkResponse: Equatable {
            case login(Profile)
            case loginFailed
            case loginFailedInvalidCredentials
            case loginFailedNoInternet
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
        case let ._internal(internalAction):
            return reduceInternal(into: &state, internalAction: internalAction)
        case .ui(.loginPressed):
            state.networkIndicator = true
            return Effects.loginPressed(loginClient: loginClient, userID: state.userID, apiToken: state.apiToken)
        case let .ui(.userIdChanged(userID)):
            state.userID = userID
            return .none
        case let .ui(.apiTokenChanged(token)):
            state.apiToken = token
            return .none
        case .ui(.alert(.dismissed)):
            state.alert = nil
            return .none
        case let .networkResponse(networkAction):
            state.networkIndicator = false
            return reduceNetworkResponse(into: &state, networkAction: networkAction)
        case .delegate:
            // intentional, should be handled by a higher level reducer
            return .none
        }
    }
    
    private func reduceInternal(into state: inout State, internalAction: Action.Internal) -> EffectTask<Action> {
        switch internalAction {
        case .viewCreated:
            return Effects.viewCreated(loginClient: loginClient)
        case let .credentialsLoaded(userID, apiToken):
            state.userID = userID
            state.apiToken = apiToken
            return .init(value: ._internal(.tryAutologin))
        case .tryAutologin:
            return .init(value: .ui(.loginPressed))
        }
    }
    
    private func reduceNetworkResponse(into state: inout State, networkAction: Action.NetworkResponse) -> EffectTask<Action> {
        switch networkAction {
        case .login:
            return .init(value: .delegate(.didLogin))
        case .loginFailed,
             .loginFailedInvalidCredentials:
            state.alert = AlertState {
                TextState("Login failed")
            } actions: {
                ButtonState(role: .cancel) { TextState("OK") }
            } message: {
                TextState("Invalid credentials (?)")
            }
            return .none
        case .loginFailedNoInternet:
            state.alert = AlertState {
                TextState("Login failed")
            } actions: {
                ButtonState(role: .cancel) { TextState("OK") }
            } message: {
                TextState("Internet connection appears to be offline")
            }
            return .none
        }
    }

    private struct Effects {
        static func loginPressed(loginClient: LoginClient, userID: String, apiToken: String) -> EffectTask<Action> {
            return .task {
                let profile: Profile
                do {
                    profile = try await loginClient.fetchProfile(userID, apiToken)
                } catch let error {
                    guard let loginError = error as? LoginClientError else {
                        return .networkResponse(.loginFailed)
                    }
                    switch loginError {
                    case LoginClientError.noInternet:
                        return .networkResponse(.loginFailedNoInternet)
                    case LoginClientError.authenticationFailed:
                        return .networkResponse(.loginFailedInvalidCredentials)
                    case LoginClientError.requestFailed,
                         LoginClientError.responseParsingFailed:
                        return .networkResponse(.loginFailed)
                    }
                }
                loginClient.saveCredentials(userID, apiToken)
                return .networkResponse(.login(profile))
            }
        }
        
        static func viewCreated(loginClient: LoginClient) -> EffectTask<Action> {
            return .task {
                let (userID, apiToken) = loginClient.loadCredentials()
                return ._internal(
                    .credentialsLoaded(userID, apiToken)
                )
            }
        }
    }
}
