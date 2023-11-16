//
//  TaskCellViewModel.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 16/11/2023.
//

import Foundation

struct TaskCellViewModel {
    
    let task: Task
    
    var iconUnicode: String {
        switch task.status {
        case .pending:
            return "\u{251A}" // □
        case .expired:
            return "\u{2718}" // ✘
        case .complete:
            return "\u{2713}" // ✓
        case .other(_):
            return "\u{003F}" // ?
        }
    }
    
    var statusLine: String {
        task.statusLine
    }
}

private extension Task {
    var statusLine: String {
        "\(cents/100)$ * \(due) * \(status.description)"
    }
}
