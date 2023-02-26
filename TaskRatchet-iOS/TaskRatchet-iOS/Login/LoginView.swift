//
//  ContentView.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 26/02/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var userID: String = ""
    @State private var apiToken: String = ""
    
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
            
            VStack(alignment: .leading) {
                HStack {
                    Text("UserID")
                    TextField("userID", text: $userID)
                }
                HStack {
                    Text("API Token")
                    TextField("API Token", text: $userID)
                }
            }
            .padding()
            
            Button("Login") {
                print("Login button tapped")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
