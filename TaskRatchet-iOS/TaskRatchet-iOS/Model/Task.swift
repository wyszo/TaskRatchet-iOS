//
//  Task.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct Task: Codable, Equatable {
    
    enum Status: Codable, Equatable {
        case pending
        case expired
        case complete
        case other(String)
        
        var description: String {
            switch self {
                case .pending: return "Pending"
                case .expired: return "Expired"
                case .complete: return "Complete"
                case .other(let value): return value
            }
        }
        
        init(rawValue: String) {
            let rawValue = rawValue.lowercased()
            
            if rawValue == "pending" {
                self = .pending
            } else if rawValue == "expired" {
                self = .expired
            } else if rawValue == "complete" {
                self = .complete
            } else {
                self = .other(rawValue)
            }
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            self = Status(rawValue: value)
        }
    }
    
    let id: String
    let task: String
    let due: String
    let due_timestamp: Int
    let cents: Int
    let complete: Bool
    let status: Status
    let timezone: String
}

extension Task {
    var isPending: Bool {
        status == .pending
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
            status: .pending,
            timezone: "timezone"
        )
    }()
}
