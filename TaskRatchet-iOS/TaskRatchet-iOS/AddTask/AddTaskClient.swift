//
//  AddTaskClient.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

struct AddTaskClient {
    typealias AddTaskType = (_ task: NewTask, _ credentials: Credentials) async throws -> Task
    let addTask: AddTaskType
}

typealias AddTaskClientError = NetworkResponseError

extension AddTaskClient {
    static let live = Self(
        addTask: { newTask, credentials in
            let (data, response): (Data, URLResponse)
            do {
                let request = API.addTaskRequest(task: newTask, credentials: credentials)
                (data, response) = try await URLSession.shared.data(for: request)
            } catch let error as URLError {
                throw AddTaskClientError(from: error)
            } catch {
                throw AddTaskClientError.requestFailed
            }
            if let error = AddTaskClientError(from: response) { throw error }
            return try data.parse()
        }
    )
}

extension AddTaskClient {
    static let mock = Self(addTask: { _, _ in return Task.mocked })
}
