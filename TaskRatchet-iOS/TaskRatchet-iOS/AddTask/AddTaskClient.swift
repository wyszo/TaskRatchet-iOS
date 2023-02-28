//
//  AddTaskClient.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

struct AddTaskClient {
    typealias AddTaskType = (_ task: NewTask) async throws -> ()
    let addTask: AddTaskType
}

typealias AddTaskClientError = NetworkResponseError

extension AddTaskClient {
    static let live = Self(
        addTask: { newTask in
           // Not implemented yet
        }
    )
}

extension AddTaskClient {
    static let mock = Self(addTask: { _ in })
}
