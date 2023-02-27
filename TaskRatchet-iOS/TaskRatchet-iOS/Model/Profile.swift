//
//  Profile.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct Profile: Codable, Equatable {
    let id: String
    let name: String
    let email: String
    let timezone: String
    // cards, integrations - unused
}
