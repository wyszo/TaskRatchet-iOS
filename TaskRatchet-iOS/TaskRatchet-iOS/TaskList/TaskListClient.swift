//
//  TaskListClient.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct TaskListClient {
    typealias FetchAllType = (_ userID: String, _ apiToken: String) async throws -> [Task]
    typealias LoadCredentialsType = () -> (String, String)
    
    let fetchAll: FetchAllType
    let loadCredentials: LoadCredentialsType
}

typealias TaskListClientError = NetworkResponseError

extension TaskListClient {
    static let live = Self(
        fetchAll: { userID, apiToken in
            let (data, response): (Data, URLResponse)
            do {
                (data, response) = try await URLSession.shared.data(
                    for: API.authenticatedRequestFor(.fetchAllTasks,
                         userID: userID,
                         apiToken: apiToken
                    )
                )
            } catch let error as URLError {
                throw TaskListClientError(from: error)
            } catch {
                throw TaskListClientError.requestFailed
            }
            if let error = AddTaskClientError(from: response) { throw error }
            return try data.parse()
        },
        loadCredentials: DataStore.live.loadCredentials
    )
}

extension TaskListClient {
    static let mock = Self(
        fetchAll: { _, _ in
            return []
        },
        loadCredentials: { return ("userID", "API-token") }
    )
}
