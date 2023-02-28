//
//  NewTask.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

struct NewTask: Codable, Equatable {
    var id: String
    var task: String
    var due: String
    var cents: Int

    internal init(
        id: String = UUID().uuidString,
        task: String = "New task",
        due: String = "",
        cents: Int = 500
    ) {
        self.id = id
        self.task = task
        self.due = due
        self.cents = cents
    }
}
