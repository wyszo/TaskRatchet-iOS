//
//  API.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct API {
    static let baseURL = "https://api.taskratchet.com/api1/"
    
    enum HttpMethod: String, Equatable {
        case get = "GET"
        case post = "POST"
    }
    
    enum Endpoint: RawRepresentable {
        case fetchProfile
        case fetchAllTasks
        case addNewTask
        
        private enum Path: String {
            case me = "me"
            case meTasks = "me/tasks"
        }
        
        var rawValue: (HttpMethod, String) {
            switch self {
            case .fetchProfile:
                return (.get, Path.me.rawValue)
            case .fetchAllTasks:
                return (.get, Path.meTasks.rawValue)
            case .addNewTask:
                return (.post, Path.meTasks.rawValue)
            }
        }
        
        init?(rawValue: (API.HttpMethod, String)) {
            switch rawValue {
            case (.get, Path.me.rawValue): self = .fetchProfile
            case (.get, Path.meTasks.rawValue): self = .fetchAllTasks
            case (.post, Path.meTasks.rawValue): self = .addNewTask
            default: return nil
            }
        }
        
        var httpMethod: String {
            return self.rawValue.0.rawValue
        }
    }
    
    static func endpointURLFor(_ endpoint: Endpoint) -> URL {
        guard let url = URL(string: baseURL + endpoint.rawValue.1) else {
            assertionFailure("Invalid URL!")
            return URL(string: baseURL + "invalid")!
        }
        return url
    }

    static func authenticatedRequestFor(_ endpoint: Endpoint, credentials: Credentials) -> URLRequest {
        guard endpoint != .addNewTask else {
            fatalError("API misuse, call `addTaskRequest` method instead")
        }
        
        return authenticatedRequestFor(endpoint, userID: credentials.userID, apiToken: credentials.apiToken)
    }
    
    static func addTaskRequest(task: NewTask, credentials: Credentials) -> URLRequest {
        
        // TODO: encode task body parameters
        fatalError("Not imlemented yet: add correct parameters to the network request as per the API spec file")
    }
    
    static func authenticatedRequestFor(_ endpoint: Endpoint, userID: String, apiToken: String) -> URLRequest {
        var request = URLRequest(url: API.endpointURLFor(endpoint))
        request.addValue(userID, forHTTPHeaderField: "X-Taskratchet-Userid")
        request.addValue(apiToken, forHTTPHeaderField: "X-Taskratchet-Token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = endpoint.httpMethod
        return request
    }
}
