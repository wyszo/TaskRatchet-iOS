//
//  Credentials.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 01/03/2023.
//

import Foundation

struct Credentials: Equatable {
    let userID: String
    let apiToken: String
}

extension Credentials {
    static let mock = Self(
        userID: "mockedUserID",
        apiToken: "mockedApiToken"
    )
}
