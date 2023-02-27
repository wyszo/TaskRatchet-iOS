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
