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
    case responseParsingFailure
}

extension LoginClient {
    static let live = Self { userID, apiToken in
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(from: API.endpointURLFor(.profile))
        } catch {
            throw LoginError.requestFailed
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
