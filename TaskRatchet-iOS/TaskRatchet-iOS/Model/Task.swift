//
//  Task.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct Task: Codable, Equatable {
    let id: String
    let task: String
    let due: String
    let due_timestamp: Int
    let cents: Int
    let complete: Bool
    let status: String
    let timezone: String
}

extension Task {
    var isPending: Bool {
        status == "pending"
    }
}

extension Task {
    static let mocked: Self = {
        return .init(
            id: "12345",
            task: "Mow the lawn",
            due: "27/02/2023, 11:59PM",
            due_timestamp: 1000,
            cents: 500,
            complete: false,
            status: "pending",
            timezone: "timezone"
        )
    }()
}
