//
//  API.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct API {
    static let baseURL = "https://api.taskratchet.com/api1/"
    
    enum Endpoint: String {
        case profile = "me"
    }
    
    static func endpointURLFor(_ endpoint: Endpoint) -> URL {
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            assertionFailure("Invalid URL!")
            return URL(string: baseURL + "invalid")!
        }
        return url
    }
}
