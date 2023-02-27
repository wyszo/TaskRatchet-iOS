//
//  ContentView.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import ComposableArchitecture
import SwiftUI

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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: .init(),
                reducer: Login(loginClient: .mock)
            )
        )
    }
}

extension LoginClient {
    static let mock = Self { _, _ in
        return .init(
            id: "id",
            name: "name",
            email: "email",
            timezone: "timezone"
        )
    }
}
