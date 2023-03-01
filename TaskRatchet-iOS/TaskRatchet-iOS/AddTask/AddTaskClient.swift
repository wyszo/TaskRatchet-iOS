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
                (data, response) = try await URLSession.shared.data(
                    for: API.authenticatedRequestFor(.addNewTask, credentials: credentials)
                )
            } catch let error {
                // TODO: better error handling (generalise from LoginClient implementation)
                throw AddTaskClientError.requestFailed
            }

            let task: Task
            do {
                task = try JSONDecoder().decode(Task.self, from: data)
            } catch {
                throw AddTaskClientError.responseParsingFailed
            }
            return task
        }
    )
}

extension AddTaskClient {
    static let mock = Self(addTask: { _, _ in return Task.sample })
}

private extension Task {
    static let sample: Self = {
        return .init(
            id: "12345",
            task: "sample",
            due: "due",
            due_timestamp: 1000,
            cents: 500,
            complete: false,
            status: "status",
            timezone: "timezone"
        )
    }()
}
