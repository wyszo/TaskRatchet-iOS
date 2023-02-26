//
//  ContentView.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import SwiftUI
import ComposableArchitecture

struct Login: ReducerProtocol {
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
            case login
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
            // not implented yet
            // implement network request as a side-effect
            return .none
        case let .ui(.userIdChanged(userID)):
            state.userID = userID
            return .none
        case let .ui(.apiTokenChanged(token)):
            state.apiToken = token
            return .none
        case .networkResponse(.login):
            // not implented yet
            return .none
        case .delegate:
            // intentional, should be handled by a higher level reducer
            return .none
        }
    }
}

struct LoginView: View {
    let store: StoreOf<Login>
    
    var body: some View {
        VStack {
            VStack(spacing: 5.0) {
                Text("Task Ratchet")
                    .font(.title)
                Text("Unofficial mobile client")
                    .font(.title3)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 10.0) {
                Text("1) Register account via web: **app.taskratchet.com**")
                Text("2) Go to **Account settings**")
                Text("3) Click **Request API token**")
                Text("4) Paste **userID** and **API Token** below")
            }
            .padding()
            
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack(alignment: .leading) {
                    HStack {
                        Text("UserID")
                        TextField("userID",
                            text: viewStore.binding(
                                get: \.userID,
                                send: { .ui(.userIdChanged($0)) }
                            )
                        )
                    }
                    HStack {
                        Text("API Token")
                        TextField("API token",
                            text: viewStore.binding(
                                get: \.apiToken,
                                send: { .ui(.apiTokenChanged($0)) }
                            )
                        )
                    }
                }
                .padding()
                
                Button("Login") { viewStore.send(.ui(.loginPressed)) }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: .init(),
                reducer: Login()
            )
        )
    }
}
