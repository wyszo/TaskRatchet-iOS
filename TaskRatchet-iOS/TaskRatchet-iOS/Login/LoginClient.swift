//
//  LoginClient.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct LoginClient {
    typealias FetchProfileType = (_ userID: String, _ apiToken: String) async throws -> Profile

    let fetchProfile: FetchProfileType
}

enum LoginError: Error {
    case requestFailed
    case noInternet
    case authenticationFailed
    case responseParsingFailure
}

extension LoginClient {
    static let live = Self { userID, apiToken in
        let (data, response): (Data, URLResponse)
        do {
            var request = URLRequest(url: API.endpointURLFor(.profile))
            request.addValue(userID, forHTTPHeaderField: "X-Taskratchet-Userid")
            request.addValue(apiToken, forHTTPHeaderField: "X-Taskratchet-Token")
            
            (data, response) = try await URLSession.shared.data(for: request)
        } catch let error {
            print(error)
            if let urlError = error as? URLError {
                if [.notConnectedToInternet,
                    .networkConnectionLost
                ].contains(urlError.code) {
                    throw LoginError.noInternet
                }
            }
            throw LoginError.requestFailed
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 403 {
                throw LoginError.authenticationFailed
            }
        }

        let profile: Profile
        do {
            profile = try JSONDecoder().decode(Profile.self, from: data)
        } catch {
            throw LoginError.responseParsingFailure
        }
        return profile
    }
}
