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

enum TaskListClientError: Error {
    case requestFailed
    case responseParsingFailed
}

extension TaskListClient {
    static let live = Self(
        fetchAll: { userID, apiToken in
            let (data, response): (Data, URLResponse)
            do {
                (data, response) = try await URLSession.shared.data(
                    for: API.authenticatedRequestFor(.allTasks,
                         userID: userID,
                         apiToken: apiToken
                    )
                )
            } catch let error {
                // TODO: handle no internet connection
                throw TaskListClientError.requestFailed
            }
            
            let tasks: [Task]
            do {
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                throw TaskListClientError.responseParsingFailed
            }
            return tasks
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
