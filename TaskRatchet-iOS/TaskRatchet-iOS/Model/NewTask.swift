//
//  NewTask.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

struct NewTask: Codable, Equatable {
    var task: String
    var due: String
    var cents: Int

    internal init(
        task: String = "New task",
        due: String = "",
        cents: Int = 500
    ) {
        self.task = task
        self.due = due
        self.cents = cents
    }
}

extension NewTask {
    var stakes: MoneyAmount {
        MoneyAmount(cents: cents)
    }
}
