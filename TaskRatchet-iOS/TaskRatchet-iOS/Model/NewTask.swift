//
//  NewTask.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

struct NewTask: Equatable {
    var task: String
    var dueDate: Date
    var cents: Int
    
    internal init(
        task: String = "New task",
        dueDate: Date = Date.weekFromNow,
        cents: Int = 500
    ) {
        self.task = task
        self.dueDate = dueDate
        self.cents = cents
    }

    private enum CodingKeys: String, CodingKey {
        case task
        case due
        case cents
    }
}

extension NewTask: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(task, forKey: .task)
        try container.encode(dueDate.apiFormat, forKey: .due)
        try container.encode(cents, forKey: .cents)
    }
}

extension NewTask: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        task = try container.decode(String.self, forKey: .task)
        cents = try container.decode(Int.self, forKey: .cents)

        let dueDateString = try container.decode(String.self, forKey: .due)
        if let date = dueDateString.apiFormat {
            dueDate = date
        } else {
            assertionFailure("Date decoding error, invalid date format")
            dueDate = Date.weekFromNow
        }
    }
}

extension NewTask {
    var stakes: MoneyAmount {
        MoneyAmount(cents: cents)
    }
}



